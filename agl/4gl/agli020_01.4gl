#該程式未解開Section, 採用最新樣板產出!
{<section id="agli020_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-10-11 11:10:51), PR版次:0006(2016-11-28 15:29:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000300
#+ Filename...: agli020_01
#+ Description: 
#+ Creator....: 02299(2013-08-27 15:18:55)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="agli020_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#13  2016/03/25  by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160905-00007#3   2016/09/05  By zhujing 调整系统中无ENT的SQL条件增加ent
#161111-00028#8   2016/11/28  by 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_glac_m        RECORD
       glac001 LIKE glac_t.glac001, 
   glac001_desc LIKE type_t.chr80, 
   glac002 LIKE glac_t.glac002, 
   glacl004 LIKE glacl_t.glacl004, 
   glacl005 LIKE glacl_t.glacl005, 
   glacstus LIKE glac_t.glacstus, 
   glac003 LIKE glac_t.glac003, 
   glac004 LIKE glac_t.glac004, 
   glac005 LIKE glac_t.glac005, 
   glac011 LIKE glac_t.glac011, 
   glac016 LIKE glac_t.glac016, 
   glac007 LIKE glac_t.glac007, 
   glac006 LIKE glac_t.glac006, 
   glac008 LIKE glac_t.glac008, 
   glac010 LIKE glac_t.glac010, 
   glac009 LIKE glac_t.glac009, 
   glac017 LIKE glac_t.glac017, 
   glac028 LIKE type_t.chr1, 
   glac018 LIKE glac_t.glac018, 
   glac029 LIKE type_t.chr1, 
   glac019 LIKE glac_t.glac019, 
   glac030 LIKE type_t.chr1, 
   glac020 LIKE glac_t.glac020, 
   glac023 LIKE glac_t.glac023, 
   glac027 LIKE glac_t.glac027, 
   glac025 LIKE glac_t.glac025, 
   glac021 LIKE glac_t.glac021, 
   glac026 LIKE glac_t.glac026, 
   glac022 LIKE glac_t.glac022, 
   glac012 LIKE glac_t.glac012, 
   glac013 LIKE glac_t.glac013, 
   glac014 LIKE glac_t.glac014, 
   glac015 LIKE glac_t.glac015
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE gwin_curr             ui.Window                #Current Window
DEFINE gfrm_curr             ui.Form                  #Current Form
DEFINE g_glac_m_t            type_g_glac_m
DEFINE g_glac_m_c            type_g_glac_m
DEFINE g_glac001_aooi070     LIKE glac_t.glac001
DEFINE g_continue            LIKE type_t.chr5
#end add-point
 
DEFINE g_glac_m        type_g_glac_m
 
   DEFINE g_glac001_t LIKE glac_t.glac001
DEFINE g_glac002_t LIKE glac_t.glac002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="agli020_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION agli020_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   ps_cmd,p_glac001,p_glac002
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
   DEFINE ps_cmd          LIKE type_t.chr5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE p_glac001       LIKE glac_t.glac001
   DEFINE p_glac002       LIKE glac_t.glac002
   DEFINE l_glaccrtdt     LIKE glac_t.glaccrtdt
   DEFINE l_glacmoddt     LIKE glac_t.glacmoddt
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_agli020_01 WITH FORM cl_ap_formpath("agl","agli020_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_continue=""
   WHENEVER ERROR CALL cl_err_msg_log
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET INT_FLAG = 0
   LET g_glac001_aooi070  = ''
   
   #給默認值
   CALL cl_set_combo_scc_part('glacstus','17','N,Y')
   CALL cl_set_combo_scc('glac003','8011')
   CALL cl_set_combo_scc('glac010','8014')
   CALL cl_set_combo_scc('glac011','8015')
   CALL cl_set_combo_scc('glac006','8012')
   CALL cl_set_combo_scc('glac007','8002')
   CALL cl_set_combo_scc('glac008','8013')
   LET l_glaccrtdt = cl_get_current()
   LET l_glacmoddt = cl_get_current()
   LET p_cmd = ps_cmd
   #新增
   IF p_cmd = 'a' THEN
   #初始化變量及標準默認值賦值
      INITIALIZE g_glac_m.* TO NULL
      LET g_glac_m.glac001 = p_glac001
      LET g_glac_m.glacstus = "Y"
      LET g_glac_m.glac003 = "3"
      LET g_glac_m.glac009 = "N"
      LET g_glac_m.glac010 = "F"
      LET g_glac_m.glac011 = "30"
      LET g_glac_m.glac016 = "N"
      LET g_glac_m.glac017 = "N"
      LET g_glac_m.glac018 = "N"
      LET g_glac_m.glac019 = "N"
      LET g_glac_m.glac020 = "N"
      LET g_glac_m.glac021 = "N"
      LET g_glac_m.glac022 = "N"
      LET g_glac_m.glac023 = "N"
      LET g_glac_m.glac025 = "N"
      LET g_glac_m.glac026 = "N"
      LET g_glac_m.glac027 = "N"
      LET g_glac_m.glac028 = "N"
      LET g_glac_m.glac029 = "N"
      LET g_glac_m.glac030 = "N"
   #根據傳入的glac001和glac002給予除科目欄位外的所有欄位的默認值
      CALL agli020_01_glac_def(p_glac001,p_glac002)
      LET g_continue="a"
   END IF 
   IF p_cmd = 'u' THEN
      SELECT UNIQUE glac001,glac002,glacstus,glac003,glac005,glac004,glac009,glac010,glac011,glac016,
                    glac013,glac012,glac014,glac015,glac006,glac007,glac008,
                    glac017,glac018,glac019,glac020,glac021,glac022,glac023,glac025,glac026,glac027,
                    glac028,glac029,glac030
        INTO g_glac_m.glac001,g_glac_m.glac002,g_glac_m.glacstus,g_glac_m.glac003,g_glac_m.glac005,g_glac_m.glac004,
             g_glac_m.glac009,g_glac_m.glac010,g_glac_m.glac011,g_glac_m.glac016,g_glac_m.glac013,g_glac_m.glac012,
             g_glac_m.glac014,g_glac_m.glac015,g_glac_m.glac006,g_glac_m.glac007,g_glac_m.glac008,
             g_glac_m.glac017,g_glac_m.glac018,g_glac_m.glac019,g_glac_m.glac020,g_glac_m.glac021,
             g_glac_m.glac022,g_glac_m.glac023,g_glac_m.glac025,g_glac_m.glac026,g_glac_m.glac027,
             g_glac_m.glac028,g_glac_m.glac029,g_glac_m.glac030
        FROM glac_t
       WHERE glacent = g_enterprise AND glac001 = p_glac001 AND glac002 = p_glac002
      CALL agli020_01_glac001_ref(g_glac_m.glac001) RETURNING g_glac_m.glac001_desc
      DISPLAY g_glac_m.glac001_desc TO glac001_desc
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glac_m.glac001
      LET g_ref_fields[2] = g_glac_m.glac002
      CALL ap_ref_array2(g_ref_fields," SELECT glacl004,glacl005 FROM glacl_t WHERE glaclent = '"
           ||g_enterprise||"' AND glacl001 = ? AND glacl002 = ? AND glacl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glac_m.glacl004 = g_rtn_fields[1]
      LET g_glac_m.glacl005 = g_rtn_fields[2]
      LET g_glac_m_t.* = g_glac_m.*
   END IF 
   
   IF p_cmd = 'c' THEN
      SELECT UNIQUE glac001,glac002,glacstus,glac003,glac005,glac004,glac009,glac010,glac011,glac016,
                    glac013,glac012,glac014,glac015,glac006,glac007,glac008,
                    glac017,glac018,glac019,glac020,glac021,glac022,glac023,glac025,glac026,glac027,
                    glac028,glac029,glac030
        INTO g_glac_m.glac001,g_glac_m.glac002,g_glac_m.glacstus,g_glac_m.glac003,g_glac_m.glac005,g_glac_m.glac004,
             g_glac_m.glac009,g_glac_m.glac010,g_glac_m.glac011,g_glac_m.glac016,g_glac_m.glac013,g_glac_m.glac012,
             g_glac_m.glac014,g_glac_m.glac015,g_glac_m.glac006,g_glac_m.glac007,g_glac_m.glac008,
             g_glac_m.glac017,g_glac_m.glac018,g_glac_m.glac019,g_glac_m.glac020,g_glac_m.glac021,
             g_glac_m.glac022,g_glac_m.glac023,g_glac_m.glac025,g_glac_m.glac026,g_glac_m.glac027,
             g_glac_m.glac028,g_glac_m.glac029,g_glac_m.glac030
        FROM glac_t
       WHERE glacent = g_enterprise AND glac001 = p_glac001 AND glac002 = p_glac002
      LEt g_glac_m.glac002 = ''
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_glac001
      LET g_ref_fields[2] = p_glac002
      CALL ap_ref_array2(g_ref_fields," SELECT glacl004,glacl005 FROM glacl_t WHERE glaclent = '"
           ||g_enterprise||"' AND glacl001 = ? AND glacl002 = ? AND glacl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glac_m.glacl004 = g_rtn_fields[1]
      LET g_glac_m.glacl005 = g_rtn_fields[2]
      LET g_glac_m_t.* = g_glac_m.*
      #CALL cl_set_comp_entry("glacl004,glacl005,glacstus,glac003,glac005,glac004,glac009,glac010,glac011,glac016,
      #              glac013,glac012,glac014,glac015,glac006,glac007,glac008,glacstus",FALSE)     
      CALL s_transaction_begin()   
      LET p_cmd = 'a'       
   END IF 
   IF cl_null(g_glac_m.glac028) THEN LET g_glac_m.glac028='N' END IF
   IF cl_null(g_glac_m.glac029) THEN LET g_glac_m.glac029='N' END IF
   IF cl_null(g_glac_m.glac030) THEN LET g_glac_m.glac030='N' END IF
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glac001",TRUE)
      CALL cl_set_comp_entry("glac002",TRUE)
   END IF
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("glac001",FALSE)
      CALL cl_set_comp_entry("glac002",FALSE)
      CALL agli020_01_glac003_set_entry()
   END IF
   CASE g_glac_m.glacstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange","authstatus/valid.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange","authstatus/void.png")
   END CASE
   WHILE TRUE
      IF g_continue = "a" THEN
         LET g_glac_m.glac002 = ""
         IF NOT cl_null(g_glac_m.glac004) THEN
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glac_m.glac001
            LET g_ref_fields[2] = g_glac_m.glac004
            CALL ap_ref_array2(g_ref_fields," SELECT glacl004,glacl005 FROM glacl_t WHERE glaclent = '"
                ||g_enterprise||"' AND glacl001 = ? AND glacl002 = ? AND glacl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glac_m.glacl004 = g_rtn_fields[1],"-"
            LET g_glac_m.glacl005 = g_rtn_fields[2]
         END IF 
      END IF 
      CALL s_transaction_begin()
       
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glac_m.glac001,g_glac_m.glac002,g_glac_m.glacl004,g_glac_m.glacl005,g_glac_m.glacstus, 
          g_glac_m.glac003,g_glac_m.glac004,g_glac_m.glac005,g_glac_m.glac011,g_glac_m.glac016,g_glac_m.glac007, 
          g_glac_m.glac006,g_glac_m.glac008,g_glac_m.glac010,g_glac_m.glac009,g_glac_m.glac017,g_glac_m.glac028, 
          g_glac_m.glac018,g_glac_m.glac029,g_glac_m.glac019,g_glac_m.glac030,g_glac_m.glac020,g_glac_m.glac023, 
          g_glac_m.glac027,g_glac_m.glac025,g_glac_m.glac021,g_glac_m.glac026,g_glac_m.glac022,g_glac_m.glac012, 
          g_glac_m.glac013,g_glac_m.glac014,g_glac_m.glac015 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_glac_m.glac001) AND NOT cl_null(g_glac_m.glac001) THEN
                  CALL n_glacl(g_glac_m.glac001,g_glac_m.glac002)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_glac_m.glac001
                  LET g_ref_fields[2] = g_glac_m.glac002
                  CALL ap_ref_array2(g_ref_fields," SELECT glacl004,glacl005 FROM glacl_t WHERE glaclent = '"
                      ||g_enterprise||"' AND glacl001 = ? AND glacl002 = ? AND glacl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_glac_m.glacl004 = g_rtn_fields[1]
                  LET g_glac_m.glacl005 = g_rtn_fields[2]
                  DISPLAY BY NAME g_glac_m.glacl004
                  DISPLAY BY NAME g_glac_m.glacl005
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac001
            
            #add-point:AFTER FIELD glac001 name="input.a.glac001"
            #此段落由子樣板a05產生
            #F檢查重複性
            IF NOT agli020_01_rep_chk(g_glac_m.glac001,g_glac_m_t.glac001,g_glac_m.glac002,g_glac_m_t.glac002,p_cmd) THEN
               LET g_glac_m.glac001 = g_glac_m_t.glac001
               NEXT FIELD glac001
            END IF 
            #欄位檢查
            DISPLAY ' ' TO glac001_desc
            IF NOT agli020_01_glac001_chk(g_glac_m.glac001) THEN
               LET g_glac_m.glac001 = g_glac_m_t.glac001
               CALL agli020_01_glac001_ref(g_glac_m.glac001) RETURNING g_glac_m.glac001_desc
               DISPLAY g_glac_m.glac001_desc TO glac001_desc
               NEXT FIELD glac001
            END IF 
            #參考欄位帶值
            CALL agli020_01_glac001_ref(g_glac_m.glac001) RETURNING g_glac_m.glac001_desc
            DISPLAY g_glac_m.glac001_desc TO glac001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac001
            #add-point:BEFORE FIELD glac001 name="input.b.glac001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac001
            #add-point:ON CHANGE glac001 name="input.g.glac001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac002
            #add-point:BEFORE FIELD glac002 name="input.b.glac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac002
            
            #add-point:AFTER FIELD glac002 name="input.a.glac002"
            #此段落由子樣板a05產生
            #檢查重複性
            IF NOT agli020_01_rep_chk(g_glac_m.glac001,g_glac_m_t.glac001,g_glac_m.glac002,g_glac_m_t.glac002,p_cmd) THEN
               LET g_glac_m.glac002 = g_glac_m_t.glac002
               NEXT FIELD glac002
            END IF 
            #下方欄位帶值
            CALL agli020_01_glac002_ref(p_cmd)
            LET g_glac002_t = g_glac_m.glac002
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac002
            #add-point:ON CHANGE glac002 name="input.g.glac002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glacl004
            #add-point:BEFORE FIELD glacl004 name="input.b.glacl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glacl004
            
            #add-point:AFTER FIELD glacl004 name="input.a.glacl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glacl004
            #add-point:ON CHANGE glacl004 name="input.g.glacl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glacl005
            #add-point:BEFORE FIELD glacl005 name="input.b.glacl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glacl005
            
            #add-point:AFTER FIELD glacl005 name="input.a.glacl005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glacl005
            #add-point:ON CHANGE glacl005 name="input.g.glacl005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glacstus
            #add-point:BEFORE FIELD glacstus name="input.b.glacstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glacstus
            
            #add-point:AFTER FIELD glacstus name="input.a.glacstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glacstus
            #add-point:ON CHANGE glacstus name="input.g.glacstus"
            CASE g_glac_m.glacstus
               WHEN "Y"
                  CALL gfrm_curr.setElementImage("statechange","authstatus/valid.png")
               WHEN "N"
                  CALL gfrm_curr.setElementImage("statechange","authstatus/void.png")
            END CASE
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac003
            #add-point:BEFORE FIELD glac003 name="input.b.glac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac003
            
            #add-point:AFTER FIELD glac003 name="input.a.glac003"
             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac003
            #add-point:ON CHANGE glac003 name="input.g.glac003"
            #对于glac005,glac004帶值
            CALL agli020_01_glac003_set_entry()
            CALL agli020_01_glac003_ref(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac004
            #add-point:BEFORE FIELD glac004 name="input.b.glac004"
            IF cl_null(g_glac_m.glac001) THEN
               NEXT FIELD glac001
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac004
            
            #add-point:AFTER FIELD glac004 name="input.a.glac004"
            IF NOT agli020_01_glac004_chk(g_glac_m.glac001,g_glac_m.glac002,g_glac_m.glac003,g_glac_m.glac004) THEN
               LET g_glac_m.glac004 = g_glac_m_t.glac004
               NEXT FIELD glac004
            END IF 
            CALL agli020_01_glac004_ref()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac004
            #add-point:ON CHANGE glac004 name="input.g.glac004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glac_m.glac005,"1","1","99","1","azz-00087",1) THEN
               NEXT FIELD glac005
            END IF 
 
 
 
            #add-point:AFTER FIELD glac005 name="input.a.glac005"
            IF g_glac_m.glac005 >99 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'test'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac005
            #add-point:BEFORE FIELD glac005 name="input.b.glac005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac005
            #add-point:ON CHANGE glac005 name="input.g.glac005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac011
            #add-point:BEFORE FIELD glac011 name="input.b.glac011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac011
            
            #add-point:AFTER FIELD glac011 name="input.a.glac011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac011
            #add-point:ON CHANGE glac011 name="input.g.glac011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac016
            #add-point:BEFORE FIELD glac016 name="input.b.glac016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac016
            
            #add-point:AFTER FIELD glac016 name="input.a.glac016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac016
            #add-point:ON CHANGE glac016 name="input.g.glac016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac007
            #add-point:BEFORE FIELD glac007 name="input.b.glac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac007
            
            #add-point:AFTER FIELD glac007 name="input.a.glac007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac007
            #add-point:ON CHANGE glac007 name="input.g.glac007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac006
            #add-point:BEFORE FIELD glac006 name="input.b.glac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac006
            
            #add-point:AFTER FIELD glac006 name="input.a.glac006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac006
            #add-point:ON CHANGE glac006 name="input.g.glac006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac008
            #add-point:BEFORE FIELD glac008 name="input.b.glac008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac008
            
            #add-point:AFTER FIELD glac008 name="input.a.glac008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac008
            #add-point:ON CHANGE glac008 name="input.g.glac008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac010
            #add-point:BEFORE FIELD glac010 name="input.b.glac010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac010
            
            #add-point:AFTER FIELD glac010 name="input.a.glac010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac010
            #add-point:ON CHANGE glac010 name="input.g.glac010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac009
            #add-point:BEFORE FIELD glac009 name="input.b.glac009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac009
            
            #add-point:AFTER FIELD glac009 name="input.a.glac009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac009
            #add-point:ON CHANGE glac009 name="input.g.glac009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac017
            #add-point:BEFORE FIELD glac017 name="input.b.glac017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac017
            
            #add-point:AFTER FIELD glac017 name="input.a.glac017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac017
            #add-point:ON CHANGE glac017 name="input.g.glac017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac028
            #add-point:BEFORE FIELD glac028 name="input.b.glac028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac028
            
            #add-point:AFTER FIELD glac028 name="input.a.glac028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac028
            #add-point:ON CHANGE glac028 name="input.g.glac028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac018
            #add-point:BEFORE FIELD glac018 name="input.b.glac018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac018
            
            #add-point:AFTER FIELD glac018 name="input.a.glac018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac018
            #add-point:ON CHANGE glac018 name="input.g.glac018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac029
            #add-point:BEFORE FIELD glac029 name="input.b.glac029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac029
            
            #add-point:AFTER FIELD glac029 name="input.a.glac029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac029
            #add-point:ON CHANGE glac029 name="input.g.glac029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac019
            #add-point:BEFORE FIELD glac019 name="input.b.glac019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac019
            
            #add-point:AFTER FIELD glac019 name="input.a.glac019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac019
            #add-point:ON CHANGE glac019 name="input.g.glac019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac030
            #add-point:BEFORE FIELD glac030 name="input.b.glac030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac030
            
            #add-point:AFTER FIELD glac030 name="input.a.glac030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac030
            #add-point:ON CHANGE glac030 name="input.g.glac030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac020
            #add-point:BEFORE FIELD glac020 name="input.b.glac020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac020
            
            #add-point:AFTER FIELD glac020 name="input.a.glac020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac020
            #add-point:ON CHANGE glac020 name="input.g.glac020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac023
            #add-point:BEFORE FIELD glac023 name="input.b.glac023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac023
            
            #add-point:AFTER FIELD glac023 name="input.a.glac023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac023
            #add-point:ON CHANGE glac023 name="input.g.glac023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac027
            #add-point:BEFORE FIELD glac027 name="input.b.glac027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac027
            
            #add-point:AFTER FIELD glac027 name="input.a.glac027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac027
            #add-point:ON CHANGE glac027 name="input.g.glac027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac025
            #add-point:BEFORE FIELD glac025 name="input.b.glac025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac025
            
            #add-point:AFTER FIELD glac025 name="input.a.glac025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac025
            #add-point:ON CHANGE glac025 name="input.g.glac025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac021
            #add-point:BEFORE FIELD glac021 name="input.b.glac021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac021
            
            #add-point:AFTER FIELD glac021 name="input.a.glac021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac021
            #add-point:ON CHANGE glac021 name="input.g.glac021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac026
            #add-point:BEFORE FIELD glac026 name="input.b.glac026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac026
            
            #add-point:AFTER FIELD glac026 name="input.a.glac026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac026
            #add-point:ON CHANGE glac026 name="input.g.glac026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac022
            #add-point:BEFORE FIELD glac022 name="input.b.glac022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac022
            
            #add-point:AFTER FIELD glac022 name="input.a.glac022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac022
            #add-point:ON CHANGE glac022 name="input.g.glac022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac012
            #add-point:BEFORE FIELD glac012 name="input.b.glac012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac012
            
            #add-point:AFTER FIELD glac012 name="input.a.glac012"
            IF NOT agli020_01_oocq3006_chk(g_glac_m.glac012) THEN
               LET g_glac_m.glac012 = g_glac_m_t.glac012
               NEXT FIELD glac012
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac012
            #add-point:ON CHANGE glac012 name="input.g.glac012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac013
            #add-point:BEFORE FIELD glac013 name="input.b.glac013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac013
            
            #add-point:AFTER FIELD glac013 name="input.a.glac013"
            IF NOT agli020_01_oocq3006_chk(g_glac_m.glac013) THEN
               LET g_glac_m.glac013 = g_glac_m_t.glac013
               NEXT FIELD glac013
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac013
            #add-point:ON CHANGE glac013 name="input.g.glac013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac014
            #add-point:BEFORE FIELD glac014 name="input.b.glac014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac014
            
            #add-point:AFTER FIELD glac014 name="input.a.glac014"
            IF NOT agli020_01_oocq3006_chk(g_glac_m.glac014) THEN
               LET g_glac_m.glac014 = g_glac_m_t.glac014
               NEXT FIELD glac014
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac014
            #add-point:ON CHANGE glac014 name="input.g.glac014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glac015
            #add-point:BEFORE FIELD glac015 name="input.b.glac015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glac015
            
            #add-point:AFTER FIELD glac015 name="input.a.glac015"
            IF NOT agli020_01_oocq3006_chk(g_glac_m.glac015) THEN
               LET g_glac_m.glac015 = g_glac_m_t.glac015
               NEXT FIELD glac015
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glac015
            #add-point:ON CHANGE glac015 name="input.g.glac015"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac001
            #add-point:ON ACTION controlp INFIELD glac001 name="input.c.glac001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glac_m.glac001             #給予default值

            #給予arg

            CALL q_ooal002_1()                                #呼叫開窗

            LET g_glac_m.glac001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glac_m.glac001 TO glac001              #顯示到畫面上
            CALL agli020_01_glac001_ref(g_glac_m.glac001) RETURNING g_glac_m.glac001_desc
            DISPLAY g_glac_m.glac001_desc TO glac001_desc
            NEXT FIELD glac001                          #返回原欄位
             

            #END add-point
 
 
         #Ctrlp:input.c.glac002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac002
            #add-point:ON ACTION controlp INFIELD glac002 name="input.c.glac002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glacl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glacl004
            #add-point:ON ACTION controlp INFIELD glacl004 name="input.c.glacl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.glacl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glacl005
            #add-point:ON ACTION controlp INFIELD glacl005 name="input.c.glacl005"
            
            #END add-point
 
 
         #Ctrlp:input.c.glacstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glacstus
            #add-point:ON ACTION controlp INFIELD glacstus name="input.c.glacstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac003
            #add-point:ON ACTION controlp INFIELD glac003 name="input.c.glac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac004
            #add-point:ON ACTION controlp INFIELD glac004 name="input.c.glac004"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glac_m.glac004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glac_m.glac001 #科目參照表號
            LET g_qryparam.where = " glac003 = '1' "
            CALL q_glac()                                #呼叫開窗

            LET g_glac_m.glac004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glac_m.glac004 TO glac004              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glac004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac005
            #add-point:ON ACTION controlp INFIELD glac005 name="input.c.glac005"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac011
            #add-point:ON ACTION controlp INFIELD glac011 name="input.c.glac011"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac016
            #add-point:ON ACTION controlp INFIELD glac016 name="input.c.glac016"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac007
            #add-point:ON ACTION controlp INFIELD glac007 name="input.c.glac007"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac006
            #add-point:ON ACTION controlp INFIELD glac006 name="input.c.glac006"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac008
            #add-point:ON ACTION controlp INFIELD glac008 name="input.c.glac008"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac010
            #add-point:ON ACTION controlp INFIELD glac010 name="input.c.glac010"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac009
            #add-point:ON ACTION controlp INFIELD glac009 name="input.c.glac009"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac017
            #add-point:ON ACTION controlp INFIELD glac017 name="input.c.glac017"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac028
            #add-point:ON ACTION controlp INFIELD glac028 name="input.c.glac028"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac018
            #add-point:ON ACTION controlp INFIELD glac018 name="input.c.glac018"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac029
            #add-point:ON ACTION controlp INFIELD glac029 name="input.c.glac029"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac019
            #add-point:ON ACTION controlp INFIELD glac019 name="input.c.glac019"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac030
            #add-point:ON ACTION controlp INFIELD glac030 name="input.c.glac030"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac020
            #add-point:ON ACTION controlp INFIELD glac020 name="input.c.glac020"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac023
            #add-point:ON ACTION controlp INFIELD glac023 name="input.c.glac023"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac027
            #add-point:ON ACTION controlp INFIELD glac027 name="input.c.glac027"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac025
            #add-point:ON ACTION controlp INFIELD glac025 name="input.c.glac025"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac021
            #add-point:ON ACTION controlp INFIELD glac021 name="input.c.glac021"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac026
            #add-point:ON ACTION controlp INFIELD glac026 name="input.c.glac026"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac022
            #add-point:ON ACTION controlp INFIELD glac022 name="input.c.glac022"
            
            #END add-point
 
 
         #Ctrlp:input.c.glac012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac012
            #add-point:ON ACTION controlp INFIELD glac012 name="input.c.glac012"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glac_m.glac012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3006" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_glac_m.glac012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glac_m.glac012 TO glac012              #顯示到畫面上

            NEXT FIELD glac012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glac013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac013
            #add-point:ON ACTION controlp INFIELD glac013 name="input.c.glac013"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glac_m.glac013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3006" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_glac_m.glac013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glac_m.glac013 TO glac013              #顯示到畫面上

            NEXT FIELD glac013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glac014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac014
            #add-point:ON ACTION controlp INFIELD glac014 name="input.c.glac014"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glac_m.glac014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3006" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_glac_m.glac014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glac_m.glac014 TO glac014              #顯示到畫面上

            NEXT FIELD glac014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glac015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glac015
            #add-point:ON ACTION controlp INFIELD glac015 name="input.c.glac015"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glac_m.glac015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3006" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_glac_m.glac015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glac_m.glac015 TO glac015              #顯示到畫面上

            NEXT FIELD glac015                          #返回原欄位


            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            IF p_cmd <> 'u' THEN
               LET l_count = 1
               SELECT COUNT(*) INTO l_count FROM glac_t
                WHERE glacent = g_enterprise AND glac001 = g_glac_m.glac001
                  AND glac002 = g_glac_m.glac002
               IF l_count = 0 THEN
                  IF NOT cl_null(g_glac001_aooi070 ) THEN
                     IF NOT s_aooi070_ins("0",g_glac001_aooi070 ) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "g_glac_m"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CONTINUE DIALOG
                     END IF
                  END IF 
                  INSERT INTO glac_t (glacent,glac001,glac002,glacstus,glac003,
                  glac005,glac004,glac009,glac010,
                  glac011,glac016,glac013,glac012,glac014,
                  glac015,glac006,glac007,glac008,
                  glac017,glac018,glac019,glac020,glac021,glac022,glac023,glac025,glac026,glac027,
                  glac028,glac029,glac030,
                  glacownid,glacowndp,glaccrtid,glaccrtdt,
                  glaccrtdp,glacmodid,glacmoddt)
                  VALUES (g_enterprise,g_glac_m.glac001,g_glac_m.glac002,g_glac_m.glacstus,g_glac_m.glac003,
                  g_glac_m.glac005,g_glac_m.glac004,g_glac_m.glac009,g_glac_m.glac010,
                  g_glac_m.glac011,g_glac_m.glac016,g_glac_m.glac013,g_glac_m.glac012,g_glac_m.glac014,
                  g_glac_m.glac015,g_glac_m.glac006,g_glac_m.glac007,g_glac_m.glac008,
                  g_glac_m.glac017,g_glac_m.glac018,g_glac_m.glac019,g_glac_m.glac020,
                  g_glac_m.glac021,g_glac_m.glac022,g_glac_m.glac023,
                  g_glac_m.glac025,g_glac_m.glac026,g_glac_m.glac027,
                  g_glac_m.glac028,g_glac_m.glac029,g_glac_m.glac030,
                  g_user,g_dept,g_user,l_glaccrtdt,g_dept,'','') 

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "g_glac_m"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                     CONTINUE DIALOG
                  END IF
                  INITIALIZE l_var_keys TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  INITIALIZE l_vars TO NULL 
                  INITIALIZE l_fields TO NULL 
                  LET l_var_keys[01] = g_glac_m.glac001
                  LET l_field_keys[01] = 'glacl001'
                  LET l_var_keys_bak[01] = ''
                  LET l_var_keys[02] = g_glac_m.glac002
                  LET l_field_keys[02] = 'glacl002'
                  LET l_var_keys_bak[02] = ''
                  LET l_var_keys[03] = g_dlang
                  LET l_field_keys[03] = 'glacl003'
                  LET l_var_keys_bak[03] = g_dlang
                  LET l_vars[01] = g_glac_m.glacl004
                  LET l_fields[01] = 'glacl004'
                  LET l_vars[02] = g_glac_m.glacl005
                  LET l_fields[02] = 'glacl005'
                  LET l_vars[03] = g_enterprise 
                  LET l_fields[03] = 'glaclent'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'glacl_t')
                  #同步新增glad_t資料
                  CALL agli020_01_glad(p_cmd) RETURNING l_success
                  IF l_success=FALSE THEN
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'std-00006'
                  LET g_errparam.extend =  g_glac_m.glac002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               IF p_cmd = 'u' THEN
                  UPDATE glac_t SET (glac001,glac002,glacstus,glac003,glac005,glac004,glac009,glac010,
                  glac011,glac016,glac013,glac012,glac014,glac015,glac006,glac007,glac008,
                  glac017,glac018,glac019,glac020,glac021,glac022,glac023,glac025,glac026,glac027,
                  glac028,glac029,glac030,
                  glacmodid,glacmoddt) = (g_glac_m.glac001,g_glac_m.glac002,g_glac_m.glacstus,g_glac_m.glac003,
                  g_glac_m.glac005,g_glac_m.glac004,g_glac_m.glac009,g_glac_m.glac010,g_glac_m.glac011,g_glac_m.glac016,
                  g_glac_m.glac013,g_glac_m.glac012,g_glac_m.glac014,g_glac_m.glac015,g_glac_m.glac006,g_glac_m.glac007,
                  g_glac_m.glac008,g_glac_m.glac017,g_glac_m.glac018,g_glac_m.glac019,g_glac_m.glac020,
                  g_glac_m.glac021,g_glac_m.glac022,g_glac_m.glac023,
                  g_glac_m.glac025,g_glac_m.glac026,g_glac_m.glac027,
                  g_glac_m.glac028,g_glac_m.glac029,g_glac_m.glac030,
                  g_user,l_glacmoddt)
                   WHERE glacent = g_enterprise AND glac001 = g_glac_m_t.glac001
                     AND glac002 = g_glac_m_t.glac002

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "g_glac_m"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  ELSE
                     INITIALIZE l_var_keys TO NULL 
                     INITIALIZE l_field_keys TO NULL 
                     INITIALIZE l_vars TO NULL 
                     INITIALIZE l_fields TO NULL 
                     LET l_var_keys[01] = g_glac_m.glac001
                     LET l_field_keys[01] = 'glacl001'
                     LET l_var_keys_bak[01] =g_glac_m_t.glac001
                     LET l_var_keys[02] = g_glac_m.glac002
                     LET l_field_keys[02] = 'glacl002'
                     LET l_var_keys_bak[02] = g_glac_m_t.glac002
                     LET l_var_keys[03] = g_dlang
                     LET l_field_keys[03] = 'glacl003'
                     LET l_var_keys_bak[03] = g_dlang
                     LET l_vars[01] = g_glac_m.glacl004
                     LET l_fields[01] = 'glacl004'
                     LET l_vars[02] = g_glac_m.glacl005
                     LET l_fields[02] = 'glacl005'
                     LET l_vars[03] = g_enterprise 
                     LET l_fields[03] = 'glaclent'
                     CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'glacl_t')
                  END IF
               ELSE
                  #复制段
               END IF
               IF g_glac_m.glac017 <> g_glac_m_t.glac017 OR g_glac_m.glac018 <> g_glac_m_t.glac018 OR
                  g_glac_m.glac019 <> g_glac_m_t.glac019 OR g_glac_m.glac020 <> g_glac_m_t.glac020 OR
                  g_glac_m.glac021 <> g_glac_m_t.glac021 OR g_glac_m.glac022 <> g_glac_m_t.glac022 OR 
                  g_glac_m.glac023 <> g_glac_m_t.glac023 OR g_glac_m.glac025 <> g_glac_m_t.glac025 OR 
                  g_glac_m.glac026 <> g_glac_m_t.glac026 OR g_glac_m.glac027 <> g_glac_m_t.glac027 OR
                  g_glac_m.glac028 <> g_glac_m_t.glac028 OR g_glac_m.glac029 <> g_glac_m_t.glac029 OR
                  g_glac_m.glac030 <> g_glac_m_t.glac030 
                  THEN
                  CALL agli020_01_glad(p_cmd) RETURNING l_success
                  IF l_success=FALSE THEN
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
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
   IF INT_FLAG THEN
      EXIT WHILE
   END IF 
   IF cl_null(g_continue) THEN
      EXIT WHILE
   END IF 
END WHILE

   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_agli020_01 
   
   #add-point:input段after input name="input.post_input"
   #返回參照表號和統治科目,用於主作業尋找展開的樹的坐標
   RETURN g_glac_m.glac001,g_glac002_t,g_glac_m.glac004
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agli020_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agli020_01.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION agli020_01_glac003_ref(p_cmd)
   DEFINE p_cmd LIKE type_t.chr5
   #IF p_cmd = 'a' THEN
      IF g_glac_m.glac003 = '1' THEN
         LET g_glac_m.glac004 = g_glac_m.glac002
         LET g_glac_m.glac005 = 1
      END IF 
      IF g_glac_m.glac003 = '2' THEN
         IF g_glac_m.glac004 = g_glac_m.glac002 THEN
            LET g_glac_m.glac004 = ''
         END IF 
         LET g_glac_m.glac005 = 99
      END IF 
      IF g_glac_m.glac003 = '3' THEN 
         LET g_glac_m.glac005 = '1'
         LEt g_glac_m.glac004 = g_glac_m.glac002
      END IF 
  # END IF 
END FUNCTION
#
PRIVATE FUNCTION agli020_01_glac003_set_entry()
   IF NOT cl_null(g_glac_m.glac003) THEN
      IF g_glac_m.glac003 = '3' THEN
         CALL cl_set_comp_entry('glac004,glac005',FALSE)
      ELSE
         CALL cl_set_comp_entry('glac004,glac005',TRUE)
      END IF 
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agli020_01_glac004_chk(p_glac001,p_glac002,p_glac003,p_glac004)
   DEFINE p_glac001 LIKE glac_t.glac001
   DEFINE p_glac002 LIKE glac_t.glac002
   DEFINE p_glac003 LIKE glac_t.glac003
   DEFINE p_glac004 LIKE glac_t.glac004
   IF cl_null(p_glac002) OR cl_null(p_glac004) THEN 
      RETURN TRUE 
   END IF 
   IF cl_null(p_glac003) THEN 
      LET p_glac004 = '3'
   END IF 
   #判斷開始
   #1.判斷glac004 = ‘1’，‘3’的時候，如果glac003 = glac002，return TRUE  
   #  glac004 = '3'的時候如果，glac003 ！= glac002，就報錯提示下 
   #2.判斷not (glac004 = ‘1’，‘3’;glac003 = glac002)
   #   科目編號是否存在
   #   科目編號所屬參照表號是否正確
   #   科目編號是否有效
   #   科目編號是否為統制科目
   
   IF (p_glac003 = '1' OR p_glac003 = '3') THEN
      IF p_glac004 = p_glac002 THEN
         RETURN TRUE 
      END IF 
      IF p_glac003 = '3' AND (p_glac002 != p_glac004) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00026'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE 
      END IF 
      IF p_glac003 = '1' AND (p_glac002 != p_glac004) THEN 
         IF NOT ap_chk_isExist(p_glac004,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac002 = ? AND glacstus = 'Y' AND glac003 = '1'  "||" AND glac001 = '"||p_glac001||"' ",'agl-00028',0) THEN
            RETURN FALSE
         END IF
      END if
   ELSE
      IF NOT ap_chk_isExist(p_glac004,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac002 = ? ",'agl-00011',0) THEN
         RETURN FALSE
      END IF
      IF NOT ap_chk_isExist(p_glac004,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac002 = ? "||" AND  glac001 = '"||p_glac001||"' ",'agl-00009',0) THEN
         RETURN FALSE
      END IF
#      IF NOT ap_chk_isExist(p_glac004,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac002 = ? AND glacstus = 'Y' "||" AND glac001 = '"||p_glac001||"' ",'agl-00012',0) THEN
       IF NOT ap_chk_isExist(p_glac004,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac002 = ? AND glacstus = 'Y' "||" AND glac001 = '"||p_glac001||"' ",'sub-01302','agli020') THEN #160318-00005#13 mod
         RETURN FALSE
      END IF
      IF NOT ap_chk_isExist(p_glac004,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" ||g_enterprise|| "' AND "||"glac002 = ? AND glacstus = 'Y' AND glac003 = '1'  "||" AND glac001 = '"||p_glac001||"' ",'agl-00028',0) THEN
         RETURN FALSE
      END IF
      
      IF p_glac003 = '2' AND p_glac002 = p_glac004 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00028'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE 
      END IF 
   END IF 
   RETURN TRUE
END FUNCTION
#glac001欄位檢查
PRIVATE FUNCTION agli020_01_glac001_chk(p_glac001)
   DEFINE p_glac001 LIKE glac_t.glac001
   DEFINE r_success LIKE type_t.num5
   DEFINE l_n       LIKE type_t.num5

   LET r_success = TRUE
   LET g_glac001_aooi070  = ''
   IF NOT cl_null(p_glac001) THEN
      #檢查是否存在且參照表類型為0
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM ooal_t 
       WHERE ooalent = g_enterprise AND ooal001 = '0' AND ooal002 = p_glac001
      IF l_n = 0 THEN
         IF cl_ask_confirm("aoo-00076") THEN   
            LET g_glac001_aooi070 = p_glac001
            RETURN r_success
         ELSE
            LET r_success = FALSE 
         END IF 
      END IF 
      #檢查是否有效
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glac001,"SELECT COUNT(*) FROM ooal_t WHERE "
#            ||"ooalent = '" ||g_enterprise|| "' AND "||"ooal001 = '0' AND ooal002 = ? AND ooalstus = 'Y'  ",'agl-00004',0) THEN
             ||"ooalent = '" ||g_enterprise|| "' AND "||"ooal001 = '0' AND ooal002 = ? AND ooalstus = 'Y'  ", 'sub-01302','aooi070') THEN #160318-00005#13 mod 
            LET r_success = FALSE
         END IF 
      END IF

   END IF 
   RETURN r_success
END FUNCTION
#glac001帶值
PRIVATE FUNCTION agli020_01_glac001_ref(p_glac001)
   DEFINE p_glac001 LIKE glac_t.glac001
   DEFINE r_ooall004 LIKE ooall_t.ooall004
   LET r_ooall004 = ''
   IF NOT cl_null(p_glac001) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_glac001
      CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE "
            ||"ooallent = '" ||g_enterprise|| "' AND "
            ||"ooall001 = '0' AND ooall002 = ? AND ooall003 = '"||g_lang||"'","") 
       RETURNING g_rtn_fields
      LET r_ooall004 = g_rtn_fields[1]
   END IF 
   RETURN r_ooall004
END FUNCTION
#+
PRIVATE FUNCTION agli020_01_glac002_ref(p_cmd)
   DEFINE p_cmd LIKE type_t.chr5
   IF p_cmd = 'a' THEN
      IF g_glac_m.glac003 = '1' THEN
         IF cl_null(g_glac_m.glac004) THEN
            LET g_glac_m.glac004 = g_glac_m.glac002
            LET g_glac_m.glac005 = 1
         END IF 
      END IF 
      IF g_glac_m.glac003 = '2' THEN
         IF g_glac_m.glac004 = g_glac_m.glac002 THEN
            LET g_glac_m.glac004 = ''
         END IF 
         IF cl_null(g_glac_m.glac005) THEN
            LET g_glac_m.glac005 = 99
         END IF 
      END IF 
      IF g_glac_m.glac003 = '3' THEN 
         LET g_glac_m.glac005 = '1'
         LEt g_glac_m.glac004 = g_glac_m.glac002
      END IF 
   END IF 
   IF p_cmd = "c" THEN
      IF g_glac_m.glac003 = '1' THEN
         LET g_glac_m.glac004 = g_glac_m.glac002
         LET g_glac_m.glac005 = 1
      END IF 
      IF g_glac_m.glac003 = '3' THEN 
         LET g_glac_m.glac005 = '1'
         LEt g_glac_m.glac004 = g_glac_m.glac002
      END IF 
   END IF 
END FUNCTION
#+
PRIVATE FUNCTION agli020_01_glac004_ref()
   IF g_glac_m.glac003 = '1' THEN
      IF g_glac_m.glac004 = g_glac_m.glac002 THEN
         LET g_glac_m.glac005 = '1'
      ELSE
         SELECT glac005 INTO g_glac_m.glac005 FROM glac_t
          WHERE glac001 = g_glac_m.glac001 AND glac002 = g_glac_m.glac004
            AND glacent = g_enterprise   #160905-00007#3 add
         IF cl_null(g_glac_m.glac005) THEN
            LET g_glac_m.glac005 = 0
         END IF
         LET g_glac_m.glac005 = g_glac_m.glac005 + 1
      END IF
   END IF
END FUNCTION
#根據傳入的glac001和glac002來給予默認值
PRIVATE FUNCTION agli020_01_glac_def(p_glac001,p_glac002)
   DEFINE p_glac001 LIKE glac_t.glac001
   DEFINE p_glac002 LIKE glac_t.glac002
   DEFINE l_glac003 LIKE glac_t.glac003
   
   IF NOT cl_null(p_glac001) AND NOT cl_null(p_glac002) THEN
      SELECT glac003 INTO l_glac003 FROM glac_t 
       WHERE glacent = g_enterprise AND glac001 = p_glac001
         AND glac002 = p_glac002
      #判斷樹上面點擊的那筆資料的glac003的值
      SELECT UNIQUE glac001,glac002,glacstus,glac003,glac005,glac004,glac009,glac010,glac011,glac016,
                    glac013,glac012,glac014,glac015,glac006,glac007,glac008,
                    glac017,glac018,glac019,glac020,glac021,glac022,glac023,glac025,glac026,glac027,
                    glac028,glac029,glac030
           INTO g_glac_m.glac001,g_glac_m.glac002,g_glac_m.glacstus,g_glac_m.glac003,g_glac_m.glac005,g_glac_m.glac004,
                g_glac_m.glac009,g_glac_m.glac010,g_glac_m.glac011,g_glac_m.glac016,g_glac_m.glac013,g_glac_m.glac012,
                g_glac_m.glac014,g_glac_m.glac015,g_glac_m.glac006,g_glac_m.glac007,g_glac_m.glac008,
                g_glac_m.glac017,g_glac_m.glac018,g_glac_m.glac019,g_glac_m.glac020,g_glac_m.glac021,
                g_glac_m.glac022,g_glac_m.glac023,g_glac_m.glac025,g_glac_m.glac026,g_glac_m.glac027,
                g_glac_m.glac028,g_glac_m.glac029,g_glac_m.glac030
           FROM glac_t
          WHERE glacent = g_enterprise AND glac001 = p_glac001
            AND glac002 = p_glac002
      #glac003 不為獨立科目時，將選擇資料的所有內容全部帶給當前筆資料
      IF l_glac003 != '3' THEN
         
         #樹上面選擇資料為統制科目時候默認給glac005為99
         #為明細科目時候直接給選擇明細科目的值
         IF l_glac003 = '1' THEN
            LET g_glac_m.glac005 = '99' 
            LET g_glac_m.glac004 = g_glac_m.glac002
         END IF 
         #對glac002清空，對glac003給值2.明細
         
         LET g_glac_m.glac003 = '2'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_glac_m.glac001
         LET g_ref_fields[2] = g_glac_m.glac002
         CALL ap_ref_array2(g_ref_fields," SELECT glacl004,glacl005 FROM glacl_t WHERE glaclent = '"
              ||g_enterprise||"' AND glacl001 = ? AND glacl002 = ? AND glacl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_glac_m.glacl004 = g_rtn_fields[1],"-"
         LET g_glac_m.glacl005 = g_rtn_fields[2]
         
         CALL cl_set_comp_entry('glac004,glac005',TRUE)
      ELSE
         LET g_glac_m.glac004 = ''
         LET g_glac_m.glac005 = ''
         CALL cl_set_comp_entry('glac004,glac005',FALSE)      
      END IF 
      LET g_glac_m.glac002 = ''
   END IF 
END FUNCTION
##glac001&glac002重複性檢查
PRIVATE FUNCTION agli020_01_rep_chk(p_glac001,p_glac001_t,p_glac002,p_glac002_t,p_cmd)
   DEFINE p_glac001 LIKE glac_t.glac001
   DEFINE p_glac002 LIKE glac_t.glac002
   DEFINE p_glac001_t LIKE glac_t.glac001
   DEFINE p_glac002_t LIKE glac_t.glac002
   DEFINE p_cmd LIKE type_t.chr5
   DEFINE r_success LIKE type_t.num5
   LET r_success = TRUE
   #檢查是否為空
   IF NOT cl_null(p_glac001) AND NOT cl_null(p_glac002) THEN
      #判斷重複性
      IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (p_glac001 != p_glac001_t  OR p_glac002 != p_glac002_t ))) THEN 
         IF NOT ap_chk_notDup(p_glac001,"SELECT COUNT(*) FROM glac_t WHERE "||"glacent = '" 
            ||g_enterprise|| "' AND "||"glac001 = '"||p_glac001 ||"' AND "
            || "glac002 = '"||p_glac002 ||"'",'std-00004',0) THEN 
            LET r_success = FALSE
         END IF
      END IF
   END IF 
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 檢查科目分類
# Memo...........:
# Usage..........: CALL agli020_01_oocq3006_chk(p_oocq002)
#                  RETURNING r_success
# Input parameter: p_oocq002    傳入的科目分類編號
# Return code....: r_success    是否符合條件
# Date & Author..: 20131104 By xuxz
# Modify.........:
################################################################################
PRIVATE FUNCTION agli020_01_oocq3006_chk(p_oocq002)
   DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_oocq002) THEN
      IF r_success THEN
         IF NOT ap_chk_isExist(p_oocq002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '"
            ||g_enterprise||"' AND  oocq001 = '3006' AND oocq002 = ? ","agl-00131",0 ) THEN
            LET r_success = FALSE
         END IF
      END IF

      IF r_success THEN
         IF NOT ap_chk_isExist(p_oocq002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent = '"
#            ||g_enterprise||"' AND  oocq001 = '3006' AND oocq002 = ? AND oocqstus = 'Y'","agl-00132",0 ) THEN
             ||g_enterprise||"' AND  oocq001 = '3006' AND oocq002 = ? AND oocqstus = 'Y'",'sub-01302','agli140') THEN  #160318-00005#13 mod  
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success

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
PRIVATE FUNCTION agli020_01_glad(p_flag)
   DEFINE p_flag           LIKE type_t.chr1
   DEFINE l_sql            STRING
   DEFINE l_ask            LIKE type_t.num5  #TRUE 重新產生，FALSE不更新
   #161111-00028#8----modify----begin---------
   #DEFINE l_glad           RECORD LIKE glad_t.*
   DEFINE l_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

   #161111-00028#8----modify----end---------
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_gladld         LIKE glad_t.gladld
   
   LET l_ask=TRUE
   IF p_flag='u' THEN
      SELECT COUNT(*) INTO l_cnt FROM glad_t,glaa_t
      WHERE gladent=glaaent AND gladld=glaald
      AND glaa004=g_glac_m.glac001
      AND glad001=g_glac_m.glac002
      IF l_cnt>0 THEN
         IF cl_ask_confirm("agl-00279") THEN
            LET l_ask=TRUE
         ELSE
            LET l_ask=FALSE
         END IF
      END IF
   END IF
   
   LET l_sql="SELECT DISTINCT gladld FROM glad_t,glaa_t ",
             " WHERE glaaent=gladent AND glaald=gladld ",
             "   AND gladent=",g_enterprise,
             "   AND glaa004='",g_glac_m.glac001,"'"
   IF l_ask=FALSE THEN
      LET l_sql=l_sql," AND glad001 <> '",g_glac_m.glac002,"'"
   END IF
             
   PREPARE agli020_01_pr1 FROM l_sql
   DECLARE agli020_01_cs1 CURSOR FOR agli020_01_pr1
   
   #错误信息汇总初始化
   CALL cl_err_collect_init()
   LET g_success = 'Y'
   
   FOREACH agli020_01_cs1 INTO l_gladld
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      INITIALIZE l_glad.* TO NULL
      LET l_glad.gladent = g_enterprise
      LET l_glad.gladld = l_gladld 
      LET l_glad.glad001 = g_glac_m.glac002
      LET l_glad.glad007 = g_glac_m.glac017   
      LET l_glad.glad008 = g_glac_m.glac018
      LET l_glad.glad009 = g_glac_m.glac019
      LET l_glad.glad010 = g_glac_m.glac020
      LET l_glad.glad011 = g_glac_m.glac021
      LET l_glad.glad012 = g_glac_m.glac022
      LET l_glad.glad013 = g_glac_m.glac023
#      LET l_glad.glad014 = g_glac_m.glac024
      LET l_glad.glad015 = g_glac_m.glac025
      LET l_glad.glad016 = g_glac_m.glac026
      LET l_glad.glad027 = g_glac_m.glac027
      LET l_glad.glad030 = 'N'
      LET l_glad.glad031 = g_glac_m.glac028
      LET l_glad.glad032 = g_glac_m.glac029
      LET l_glad.glad033 = g_glac_m.glac030
      IF p_flag='a' THEN
         LET l_glad.glad002 = "N"
         LET l_glad.glad003 = "N"
         LET l_glad.glad005 = "N"
         LET l_glad.gladstus = "Y"
         LET l_glad.gladownid=g_user
         LET l_glad.gladowndp=g_dept
         LET l_glad.gladcrtid=g_user
         LET l_glad.gladcrtdt=cl_get_current()
         LET l_glad.gladcrtdp=g_dept
         INSERT INTO glad_t(gladent,gladld,glad001,glad002,glad003,glad005,glad007,glad008,glad009,glad010,glad011,
                            glad012,glad013,glad015,glad016,glad027,glad030,glad031,glad032,glad033,
                            glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,glad025,glad026,
                            gladstus,gladownid,gladowndp,gladcrtid,gladcrtdt,gladcrtdp)
                     VALUES(l_glad.gladent,l_glad.gladld,l_glad.glad001,l_glad.glad002,l_glad.glad003,l_glad.glad005,
                            l_glad.glad007,l_glad.glad008,l_glad.glad009,l_glad.glad010,l_glad.glad011,l_glad.glad012,
                            l_glad.glad013,l_glad.glad015,l_glad.glad016,l_glad.glad027,
                            l_glad.glad030,l_glad.glad031,l_glad.glad032,l_glad.glad033,
                            'N','N','N','N','N','N','N','N','N','N',
                            l_glad.gladstus,l_glad.gladownid,l_glad.gladowndp,l_glad.gladcrtid,l_glad.gladcrtdt,l_glad.gladcrtdp)
        IF SQLCA.sqlcode THEN
#           CALL cl_errmsg('ins glad_t','','',SQLCA.SQLCODE,1)
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.extend = 'ins glad_t'
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET g_success = 'N' 
        END IF
      ELSE
         IF l_ask=TRUE THEN
            UPDATE glad_t SET glad007=l_glad.glad007,
                              glad008=l_glad.glad008, 
                              glad009=l_glad.glad009,
                              glad010=l_glad.glad010, 
                              glad011=l_glad.glad011,
                              glad012=l_glad.glad012,
                              glad013=l_glad.glad013,
                              glad015=l_glad.glad015,
                              glad016=l_glad.glad016,
                              glad027=l_glad.glad027,
                              glad031=l_glad.glad031,
                              glad032=l_glad.glad032,
                              glad033=l_glad.glad033
            WHERE gladent=l_glad.gladent AND gladld=l_glad.gladld AND glad001=l_glad.glad001
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('upd glad_t','','',SQLCA.SQLCODE,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = 'upd glad_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
            END IF
         END IF
      END IF
   END FOREACH
   IF g_success='N' THEN
      CALL cl_err_collect_show()
   END IF
   RETURN g_success
END FUNCTION

 
{</section>}
 
