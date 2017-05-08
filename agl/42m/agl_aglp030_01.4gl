#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp030_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-09-14 17:02:21), PR版次:0005(2016-05-03 17:05:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: aglp030_01
#+ Description: 整批修改
#+ Creator....: 01251(2015-03-05 16:22:23)
#+ Modifier...: 02291 -SD/PR- 02599
 
{</section>}
 
{<section id="aglp030_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150827-00036#7   2015/09/14 by 02291   添加“是否是子系统科目”字段，如果打勾后在总账凭证输入时不能选该类科目
#150814-00006#1   2015/10/14 By 02599   添加10个自由核算项、借方现金变动码、贷方现金变动码
#160318-00005#16   2016/03/29 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160420-00001#9   2016/05/03 By 02599   当科目已被凭证使用，设置该科目核算项等资料时提示讯息
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
   glac012 LIKE glac_t.glac012, 
   glad001 LIKE glad_t.glad001, 
   glac013 LIKE glac_t.glac013, 
   glac007 LIKE glac_t.glac007, 
   glac014 LIKE glac_t.glac014, 
   glac015 LIKE glac_t.glac015, 
   glad007 LIKE glad_t.glad007, 
   glad031 LIKE glad_t.glad031, 
   glad002 LIKE glad_t.glad002, 
   glad006 LIKE glad_t.glad006, 
   glad006_desc LIKE type_t.chr80, 
   glad008 LIKE glad_t.glad008, 
   glad032 LIKE glad_t.glad032, 
   glad003 LIKE glad_t.glad003, 
   glad036 LIKE glad_t.glad036, 
   glad036_desc LIKE type_t.chr80, 
   glad009 LIKE glad_t.glad009, 
   glad033 LIKE glad_t.glad033, 
   glad004 LIKE glad_t.glad004, 
   glad010 LIKE glad_t.glad010, 
   glad013 LIKE glad_t.glad013, 
   glad005 LIKE glad_t.glad005, 
   glad027 LIKE glad_t.glad027, 
   glad015 LIKE glad_t.glad015, 
   glad034 LIKE glad_t.glad034, 
   glad011 LIKE glad_t.glad011, 
   glad016 LIKE glad_t.glad016, 
   glad035 LIKE glad_t.glad035, 
   glad012 LIKE glad_t.glad012, 
   glad030 LIKE glad_t.glad030, 
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
   glad0262 LIKE glad_t.glad0262, 
   gladstus LIKE glad_t.gladstus
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc        STRING
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
 
{<section id="aglp030_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglp030_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   DEFINE l_nmai001       LIKE nmai_t.nmai001  #150814-00006#1 add
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglp030_01 WITH FORM cl_ap_formpath("agl","aglp030_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('glac007','8002')
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
 
   INITIALIZE g_glad_m.* LIKE glad_t.*
   
   LET g_glad_m.glad007='N'
   LET g_glad_m.glad008='N'
   LET g_glad_m.glad009='N'
   LET g_glad_m.glad010='N'
   LET g_glad_m.glad027='N'
   LET g_glad_m.glad011='N'
   LET g_glad_m.glad012='N'
   LET g_glad_m.glad031='N'
   LET g_glad_m.glad032='N'
   LET g_glad_m.glad033='N'
   LET g_glad_m.glad034='N'
   LET g_glad_m.glad035='N'     #150827-00036#7 add
   LET g_glad_m.glad013='N'
   LET g_glad_m.glad015='N'
   LET g_glad_m.glad016='N'
   LET g_glad_m.glad030='N'
   LET g_glad_m.glad002='N'
   LET g_glad_m.glad003='N'
   LET g_glad_m.glad005='N'
   LET g_glad_m.glad017='N'
   LET g_glad_m.glad018='N'
   LET g_glad_m.glad019='N'
   LET g_glad_m.glad020='N'
   LET g_glad_m.glad021='N'
   LET g_glad_m.glad022='N'
   LET g_glad_m.glad023='N'
   LET g_glad_m.glad024='N'
   LET g_glad_m.glad025='N'
   LET g_glad_m.glad026='N'
   
   DISPLAY BY NAME g_glad_m.glad007,g_glad_m.glad031,g_glad_m.glad002,g_glad_m.glad008,g_glad_m.glad032, 
          g_glad_m.glad003,g_glad_m.glad009,g_glad_m.glad033,g_glad_m.glad004,g_glad_m.glad010,g_glad_m.glad013, 
          g_glad_m.glad005,g_glad_m.glad027,g_glad_m.glad015,g_glad_m.glad006,g_glad_m.glad011,g_glad_m.glad016, 
          g_glad_m.glad012,g_glad_m.glad030,g_glad_m.glad017,g_glad_m.glad0171,g_glad_m.glad0172,g_glad_m.glad018, 
          g_glad_m.glad0181,g_glad_m.glad0182,g_glad_m.glad019,g_glad_m.glad0191,g_glad_m.glad0192,g_glad_m.glad020, 
          g_glad_m.glad0201,g_glad_m.glad0202,g_glad_m.glad021,g_glad_m.glad0211,g_glad_m.glad0212,g_glad_m.glad022, 
          g_glad_m.glad0221,g_glad_m.glad0222,g_glad_m.glad023,g_glad_m.glad0231,g_glad_m.glad0232,g_glad_m.glad024, 
          g_glad_m.glad0241,g_glad_m.glad0242,g_glad_m.glad025,g_glad_m.glad0251,g_glad_m.glad0252,g_glad_m.glad026,
          g_glad_m.glad034,g_glad_m.glad035,g_glad_m.glad0261,g_glad_m.glad0262,g_glad_m.gladstus         #150827-00036#7 add g_glad_m.glad035

   CALL aglp030_01_set_entry()
   CALL aglp030_01_set_no_entry()
   CALL aglp030_01_set_required()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glad_m.glad007,g_glad_m.glad031,g_glad_m.glad002,g_glad_m.glad006,g_glad_m.glad008, 
          g_glad_m.glad032,g_glad_m.glad003,g_glad_m.glad036,g_glad_m.glad009,g_glad_m.glad033,g_glad_m.glad004, 
          g_glad_m.glad010,g_glad_m.glad013,g_glad_m.glad005,g_glad_m.glad027,g_glad_m.glad015,g_glad_m.glad034, 
          g_glad_m.glad011,g_glad_m.glad016,g_glad_m.glad035,g_glad_m.glad012,g_glad_m.glad030,g_glad_m.glad017, 
          g_glad_m.glad0171,g_glad_m.glad0172,g_glad_m.glad018,g_glad_m.glad0181,g_glad_m.glad0182,g_glad_m.glad019, 
          g_glad_m.glad0191,g_glad_m.glad0192,g_glad_m.glad020,g_glad_m.glad0201,g_glad_m.glad0202,g_glad_m.glad021, 
          g_glad_m.glad0211,g_glad_m.glad0212,g_glad_m.glad022,g_glad_m.glad0221,g_glad_m.glad0222,g_glad_m.glad023, 
          g_glad_m.glad0231,g_glad_m.glad0232,g_glad_m.glad024,g_glad_m.glad0241,g_glad_m.glad0242,g_glad_m.glad025, 
          g_glad_m.glad0251,g_glad_m.glad0252,g_glad_m.glad026,g_glad_m.glad0261,g_glad_m.glad0262,g_glad_m.gladstus  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad006
            
            #add-point:AFTER FIELD glad006 name="input.a.glad006"
            #150814-00006#1--mod--str--
            DISPLAY '' TO glad006_desc
            IF NOT cl_null(g_glad_m.glad006) THEN
               #判断现金变动码是否存在
               LET l_count=0
               SELECT COUNT(*) INTO l_count
                 FROM nmai_t
                WHERE nmaient=g_enterprise
                  AND nmai002=g_glad_m.glad006
               IF l_count=0 OR cl_null(l_count) THEN                      
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "anm-00008" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD glad006
               END IF
               #判断现金变动码是否有效
               LET l_count=0
               SELECT COUNT(*) INTO l_count
                 FROM nmai_t
                WHERE nmaient=g_enterprise
                  AND nmai002=g_glad_m.glad006
                  AND nmaistus='Y'
                IF l_count=0 OR cl_null(l_count) THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "" 
                   LET g_errparam.code   = 'sub-01302'  #"anm-00021" 
                   #160318-00005#16  --add--str
                   LET g_errparam.replace[1] ='anmi160'
                   LET g_errparam.replace[2] = cl_get_progname('anmi160',g_lang,"2")
                   LET g_errparam.exeprog    ='anmi160'
                   #160318-00005#16  --add--end
                   LET g_errparam.popup  =TRUE 
                   CALL cl_err()
                   NEXT FIELD glad006         
                END IF
             END IF
             INITIALIZE g_ref_fields TO NULL
             SELECT DISTINCT nmai001 INTO l_nmai001 FROM nmai_t WHERE nmaient=g_enterprise
             LET g_ref_fields[1] = l_nmai001
             LET g_ref_fields[2] = g_glad_m.glad006
             CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail001=? AND nmail002=? AND nmail003='"||g_dlang||"'","") 
                RETURNING g_rtn_fields
             LET g_glad_m.glad006_desc  = g_rtn_fields[1]
             DISPLAY g_glad_m.glad006_desc TO glad006_desc
             #150814-00006#1--mod--end
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
         BEFORE FIELD glad003
            #add-point:BEFORE FIELD glad003 name="input.b.glad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad003
            
            #add-point:AFTER FIELD glad003 name="input.a.glad003"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad003 = 'N' THEN
               LET g_glad_m.glad004 = ''
               DISPLAY g_glad_m.glad004 TO glad004
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad003
            #add-point:ON CHANGE glad003 name="input.g.glad003"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad003 = 'N' THEN
               LET g_glad_m.glad004 = ''
               DISPLAY g_glad_m.glad004 TO glad004
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad036
            
            #add-point:AFTER FIELD glad036 name="input.a.glad036"
            #150814-00006#1--add--str--
            DISPLAY '' TO glad036_desc
            IF NOT cl_null(g_glad_m.glad036) THEN
               #判断现金变动码是否存在
               LET l_count=0
               SELECT COUNT(*) INTO l_count
                 FROM nmai_t
                WHERE nmaient=g_enterprise
                  AND nmai002=g_glad_m.glad036
               IF l_count=0 OR cl_null(l_count) THEN                      
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "anm-00008" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD glad036
               END IF   
               #判断现金变动码是否有效
               LET l_count=0
               SELECT COUNT(*) INTO l_count
                 FROM nmai_t
                WHERE nmaient=g_enterprise
                  AND nmai002=g_glad_m.glad036
                  AND nmaistus='Y'
                IF l_count=0 OR cl_null(l_count) THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "" 
                   LET g_errparam.code   ='sub-01302'  #"anm-00021" 
                   #160318-00005#16  --add--str
                   LET g_errparam.replace[1] ='anmi160'
                   LET g_errparam.replace[2] = cl_get_progname('anmi160',g_lang,"2")
                   LET g_errparam.exeprog    ='anmi160'
                   #160318-00005#16  --add--end
                   LET g_errparam.popup  =TRUE 
                   CALL cl_err()
                   NEXT FIELD glad036        
                END IF
             END IF
             INITIALIZE g_ref_fields TO NULL
             SELECT DISTINCT nmai001 INTO l_nmai001 FROM nmai_t WHERE nmaient=g_enterprise
             LET g_ref_fields[1] = l_nmai001
             LET g_ref_fields[2] = g_glad_m.glad036
             CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail001=? AND nmail002=? AND nmail003='"||g_dlang||"'","") 
                RETURNING g_rtn_fields
             LET g_glad_m.glad036_desc  = g_rtn_fields[1]
             DISPLAY g_glad_m.glad036_desc TO glad036_desc
             #150814-00006#1--add--end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad036
            #add-point:BEFORE FIELD glad036 name="input.b.glad036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad036
            #add-point:ON CHANGE glad036 name="input.g.glad036"
            
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
         BEFORE FIELD glad034
            #add-point:BEFORE FIELD glad034 name="input.b.glad034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad034
            
            #add-point:AFTER FIELD glad034 name="input.a.glad034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad034
            #add-point:ON CHANGE glad034 name="input.g.glad034"
            
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
         BEFORE FIELD glad035
            #add-point:BEFORE FIELD glad035 name="input.b.glad035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad035
            
            #add-point:AFTER FIELD glad035 name="input.a.glad035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad035
            #add-point:ON CHANGE glad035 name="input.g.glad035"
            
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
         BEFORE FIELD glad017
            #add-point:BEFORE FIELD glad017 name="input.b.glad017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad017
            
            #add-point:AFTER FIELD glad017 name="input.a.glad017"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad017 = 'N' THEN
               LET g_glad_m.glad0171 = ''
               LET g_glad_m.glad0172 = ''            
               DISPLAY g_glad_m.glad0171 TO glad0171
               DISPLAY g_glad_m.glad0172 TO glad0172
               LET g_glad_m.glad0171_desc = ''
               DISPLAY g_glad_m.glad0171_desc TO glad0171_desc
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad017
            #add-point:ON CHANGE glad017 name="input.g.glad017"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0171) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0171) THEN
                  LET g_glad_m.glad0171 = ''
                  NEXT FIELD glad0171
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0171
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0171_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0171_desc

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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad018 = 'N' THEN
               LET g_glad_m.glad0181 = ''
               LET g_glad_m.glad0182 = ''
               DISPLAY g_glad_m.glad0181 TO glad0181
               DISPLAY g_glad_m.glad0182 TO glad0182
               LET g_glad_m.glad0181_desc = ''
               DISPLAY g_glad_m.glad0181_desc TO glad0181_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad018
            #add-point:ON CHANGE glad018 name="input.g.glad018"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0181) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0181) THEN
                  LET g_glad_m.glad0181 = ''
                  NEXT FIELD glad0181
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0181
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0181_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0181_desc


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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad019 = 'N' THEN
               LET g_glad_m.glad0191 = ''
               LET g_glad_m.glad0192 = ''
               DISPLAY g_glad_m.glad0191 TO glad0191
               DISPLAY g_glad_m.glad0192 TO glad0192
               LET g_glad_m.glad0191_desc = ''
               DISPLAY g_glad_m.glad0191_desc TO glad0191_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad019
            #add-point:ON CHANGE glad019 name="input.g.glad019"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0191) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0191) THEN
                  LET g_glad_m.glad0191 = ''
                  NEXT FIELD glad0191
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0191
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0191_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0191_desc


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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad020 = 'N' THEN
               LET g_glad_m.glad0201 = ''
               LET g_glad_m.glad0202 = ''
               DISPLAY g_glad_m.glad0201 TO glad0201
               DISPLAY g_glad_m.glad0202 TO glad0202
               LET g_glad_m.glad0201_desc = ''
               DISPLAY g_glad_m.glad0201_desc TO glad0201_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad020
            #add-point:ON CHANGE glad020 name="input.g.glad020"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0201) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0201) THEN
                  LET g_glad_m.glad0201 = ''
                  NEXT FIELD glad0201
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0201
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0201_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0201_desc


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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad021 = 'N' THEN
               LET g_glad_m.glad0211 = ''
               LET g_glad_m.glad0212 = ''
               DISPLAY g_glad_m.glad0221 TO glad0211
               DISPLAY g_glad_m.glad0212 TO glad0212
               LET g_glad_m.glad0211_desc = ''
               DISPLAY g_glad_m.glad0211_desc TO glad0211_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad021
            #add-point:ON CHANGE glad021 name="input.g.glad021"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad021 = 'N' THEN
               LET g_glad_m.glad0211 = ''
               LET g_glad_m.glad0212 = ''
               DISPLAY g_glad_m.glad0221 TO glad0211
               DISPLAY g_glad_m.glad0212 TO glad0212
               LET g_glad_m.glad0211_desc = ''
               DISPLAY g_glad_m.glad0211_desc TO glad0211_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0211
            
            #add-point:AFTER FIELD glad0211 name="input.a.glad0211"
            IF NOT cl_null(g_glad_m.glad0211) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0211) THEN
                  LET g_glad_m.glad0211 = ''
                  NEXT FIELD glad0211
               END IF
            END IF          

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0211
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0211_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0211_desc


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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad022 = 'N' THEN
               LET g_glad_m.glad0221 = ''
               LET g_glad_m.glad0222 = ''
               DISPLAY g_glad_m.glad0221 TO glad0221
               DISPLAY g_glad_m.glad0222 TO glad0222
               LET g_glad_m.glad0221_desc = ''
               DISPLAY g_glad_m.glad0221_desc TO glad0221_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad022
            #add-point:ON CHANGE glad022 name="input.g.glad022"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0221) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0221) THEN
                  LET g_glad_m.glad0221 = ''
                  NEXT FIELD glad0221
               END IF
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0221
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0221_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0221_desc


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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad023 = 'N' THEN
               LET g_glad_m.glad0231 = ''
               LET g_glad_m.glad0232 = ''
               DISPLAY g_glad_m.glad0231 TO glad0231
               DISPLAY g_glad_m.glad0232 TO glad0232
               LET g_glad_m.glad0231_desc = ''
               DISPLAY g_glad_m.glad0231_desc TO glad0231_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad023
            #add-point:ON CHANGE glad023 name="input.g.glad023"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0231) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0231) THEN
                  LET g_glad_m.glad0231 = ''
                  NEXT FIELD glad0231
               END IF
            END IF               
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0231
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0231_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0231_desc


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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad024 = 'N' THEN
               LET g_glad_m.glad0241 = ''
               LET g_glad_m.glad0242 = ''
               DISPLAY g_glad_m.glad0241 TO glad0241
               DISPLAY g_glad_m.glad0242 TO glad0242
               LET g_glad_m.glad0241_desc = ''
               DISPLAY g_glad_m.glad0241_desc TO glad0241_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad024
            #add-point:ON CHANGE glad024 name="input.g.glad024"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0241) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0241) THEN
                  LET g_glad_m.glad0241 = ''
                  NEXT FIELD glad0241
               END IF
            END IF              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0241
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0241_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0241_desc


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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad025 = 'N' THEN
               LET g_glad_m.glad0251 = ''
               LET g_glad_m.glad0252 = ''
               DISPLAY g_glad_m.glad0251 TO glad0251
               DISPLAY g_glad_m.glad0252 TO glad0252
               LET g_glad_m.glad0251_desc = ''
               DISPLAY g_glad_m.glad0251_desc TO glad0251_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad025
            #add-point:ON CHANGE glad025 name="input.g.glad025"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0251) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0251) THEN
                  LET g_glad_m.glad0251 = ''
                  NEXT FIELD glad0251
               END IF
            END IF              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0251
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0251_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0251_desc


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
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
            IF g_glad_m.glad026 = 'N' THEN
               LET g_glad_m.glad0261 = ''
               LET g_glad_m.glad0262 = ''
               DISPLAY g_glad_m.glad0261 TO glad0261
               DISPLAY g_glad_m.glad0262 TO glad0262
               LET g_glad_m.glad0261_desc = ''
               DISPLAY g_glad_m.glad0261_desc TO glad0261_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad026
            #add-point:ON CHANGE glad026 name="input.g.glad026"
            CALL aglp030_01_set_entry()
            CALL aglp030_01_set_no_entry()
            CALL aglp030_01_set_required()
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
            IF NOT cl_null(g_glad_m.glad0261) THEN
               IF NOT aglp030_01_glad0171_glad0261_chk(g_glad_m.glad0261) THEN
                  LET g_glad_m.glad0261 = ''
                  NEXT FIELD glad0261
               END IF
            END IF             
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0261
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0261_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0261_desc


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
            
            #END add-point 
 
 
 #欄位檢查
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
 
 
         #Ctrlp:input.c.glad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad002
            #add-point:ON ACTION controlp INFIELD glad002 name="input.c.glad002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad006
            #add-point:ON ACTION controlp INFIELD glad006 name="input.c.glad006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            CALL q_nmai002()                                #呼叫開窗

            LET g_glad_m.glad006 = g_qryparam.return1              

            DISPLAY g_glad_m.glad006 TO glad006              #

            NEXT FIELD glad006                          #返回原欄位


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
 
 
         #Ctrlp:input.c.glad003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad003
            #add-point:ON ACTION controlp INFIELD glad003 name="input.c.glad003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad036
            #add-point:ON ACTION controlp INFIELD glad036 name="input.c.glad036"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad036             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_nmai002()                                #呼叫開窗

            LET g_glad_m.glad036 = g_qryparam.return1              

            DISPLAY g_glad_m.glad036 TO glad036              #

            NEXT FIELD glad036                          #返回原欄位


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
 
 
         #Ctrlp:input.c.glad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad004
            #add-point:ON ACTION controlp INFIELD glad004 name="input.c.glad004"
            
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
 
 
         #Ctrlp:input.c.glad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad005
            #add-point:ON ACTION controlp INFIELD glad005 name="input.c.glad005"
            
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
 
 
         #Ctrlp:input.c.glad034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad034
            #add-point:ON ACTION controlp INFIELD glad034 name="input.c.glad034"
            
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
 
 
         #Ctrlp:input.c.glad035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad035
            #add-point:ON ACTION controlp INFIELD glad035 name="input.c.glad035"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad012
            #add-point:ON ACTION controlp INFIELD glad012 name="input.c.glad012"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad030
            #add-point:ON ACTION controlp INFIELD glad030 name="input.c.glad030"
            
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
              
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0171             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0171 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0171 TO glad0171              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glad_m.glad0171
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0171_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0171_desc            
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0181             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0181 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0181 TO glad0181              #
            LET g_ref_fields[1] = g_glad_m.glad0181
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0181_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0181_desc                
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0191             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0191 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0191 TO glad0191              #
            LET g_ref_fields[1] = g_glad_m.glad0191
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0191_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0191_desc                
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0201             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0201 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0201 TO glad0201              #
            LET g_ref_fields[1] = g_glad_m.glad0201
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0201_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0201_desc    
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0211             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0211 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0211 TO glad0211              #
            LET g_ref_fields[1] = g_glad_m.glad0211
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0211_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0211_desc              
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0221             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0221 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0221 TO glad0221              #
            LET g_ref_fields[1] = g_glad_m.glad0221
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0221_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0221_desc              
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0231             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0231 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0231 TO glad0231              #
            LET g_ref_fields[1] = g_glad_m.glad0231
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0231_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0231_desc              
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0241             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0241 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0241 TO glad0241              #
            LET g_ref_fields[1] = g_glad_m.glad0241
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0241_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0241_desc              
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0251             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0251 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0251 TO glad0251              #
            LET g_ref_fields[1] = g_glad_m.glad0251
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0251_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0251_desc              
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0261             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0261 = g_qryparam.return1              
            #LET g_glad_m.glael003 = g_qryparam.return2 
            DISPLAY g_glad_m.glad0261 TO glad0261              #
            LET g_ref_fields[1] = g_glad_m.glad0261
            CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glad_m.glad0261_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glad_m.glad0261_desc              
            #DISPLAY g_glad_m.glael003 TO glael003 #說明
            NEXT FIELD glad0261                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0262
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0262
            #add-point:ON ACTION controlp INFIELD glad0262 name="input.c.glad0262"
            
            #END add-point
 
 
         #Ctrlp:input.c.gladstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gladstus
            #add-point:ON ACTION controlp INFIELD gladstus name="input.c.gladstus"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON gladld,glad001,glac007,glac012,glac013,glac014,glac015
         BEFORE CONSTRUCT
      
         ON ACTION controlp INFIELD gladld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaa()
            
            DISPLAY g_qryparam.return1 TO gladld  #顯示到畫面上
            NEXT FIELD gladld                     #返回原欄位      

         ON ACTION controlp INFIELD glad001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glad001  #顯示到畫面上
            NEXT FIELD glad001                     #返回原欄位

            
         ON ACTION controlp INFIELD glac012
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3006"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glac012  #顯示到畫面上
            NEXT FIELD glac012                     #返回原欄位 

         ON ACTION controlp INFIELD glac013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3006"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glac013  #顯示到畫面上
            NEXT FIELD glac013                     #返回原欄位  
  
         ON ACTION controlp INFIELD glac014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3006"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glac014  #顯示到畫面上
            NEXT FIELD glac014                     #返回原欄位 


         ON ACTION controlp INFIELD glac015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3006"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glac015  #顯示到畫面上
            NEXT FIELD glac015                     #返回原欄位  
            
      END CONSTRUCT
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
   IF NOT INT_FLAG THEN
      CALL aglp030_01_upd()
      CALL cl_ask_confirm3("std-00012","")
   END IF   

 
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aglp030_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglp030_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglp030_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位開啟
# Memo...........:
# Usage..........: CALL aglp030_01_set_entry()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150305 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp030_01_set_entry()
   CALL cl_set_comp_entry('glad004',TRUE)
   CALL cl_set_comp_entry('glad0171,glad0172,glad0181,glad0182,glad0191,glad0192,glad0201,glad0202',TRUE)
   CALL cl_set_comp_entry('glad0211,glad0212,glad0221,gad0222,glad0231,glad0232,glad0241,glad0242',TRUE)
   CALL cl_set_comp_entry('glad0251,glad0252,glad0261,glad0262',TRUE)
END FUNCTION

################################################################################
# Descriptions...: 欄位關閉
# Memo...........:
# Usage..........: CALL aglp030_01_set_no_entry()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150305 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp030_01_set_no_entry()
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
END FUNCTION

################################################################################
# Descriptions...: 欄位是否必輸
# Memo...........:
# Usage..........: CALL aglp030_01_set_required()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150305 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp030_01_set_required()
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

################################################################################
# Descriptions...: #核算項管理類型有效性檢查
# Memo...........:
# Usage..........: CALL aglp030_01_glad0171_glad0261_chk(p_chk_str)
#                  RETURNING r_success
# Input parameter: p_chk_str   核算項管理類型
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 20150305 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp030_01_glad0171_glad0261_chk(p_chk_str)
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
             ||g_enterprise||"'  AND glae001 = ? AND glaestus = 'Y'",'sub-01302','agli041') THEN #160318-00005#16 mod 
            LET r_success = FALSE
         END IF
      END IF
   END IF 
   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 整批更新glad資料
# Memo...........:
# Usage..........: CALL aglp030_01_upd()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150305 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp030_01_upd()
DEFINE l_sql            STRING
DEFINE l_count          LIKE type_t.num10
DEFINE l_gladcrtdt      LIKE glad_t.gladcrtdt
DEFINE l_success        LIKE type_t.num5
DEFINE l_gladld         LIKE glad_t.gladld
DEFINE l_glad001        LIKE glad_t.glad001
DEFINE l_sql1           STRING #160420-00001#9

   IF cl_null(g_wc) THEN
      LET g_wc=" 1=1"
   END IF
   #150814-00006#1--mod--str--
   #現金變動碼與帳套有關，如更新現金變動碼，需要滿足之間關聯
   IF NOT cl_null(g_glad_m.glad006) AND NOT cl_null(g_glad_m.glad036) THEN
      LET g_wc=g_wc CLIPPED," AND glaa005 IN (SELECT nmai001 FROM nmai_t WHERE nmaient='",g_enterprise,"'",
                            "                 AND nmai002 IN ('",g_glad_m.glad006,"','",g_glad_m.glad036,"')",
                            "                 )"
   ELSE
      IF NOT cl_null(g_glad_m.glad006) THEN
         LET g_wc=g_wc CLIPPED," AND glaa005 IN (SELECT nmai001 FROM nmai_t WHERE nmaient='",g_enterprise,"' AND nmai002='",g_glad_m.glad006,"')"   
      END IF 
      
      IF NOT cl_null(g_glad_m.glad036) THEN
         LET g_wc=g_wc CLIPPED," AND glaa005 IN (SELECT nmai001 FROM nmai_t WHERE nmaient='",g_enterprise,"' AND nmai002='",g_glad_m.glad036,"')"   
      END IF
   END IF      
   #150814-00006#1--mod--end
   #沒有滿足條件的資料
   LET l_count=0
   LET l_sql="SELECT COUNT(*) ",
             "  FROM glac_t,glaa_t,glad_t",
             " WHERE glacent='",g_enterprise,"'",
             "   AND ", g_wc CLIPPED,
             "   AND glacent=glaaent",
             "   AND glacent=gladent",
             "   AND glac002=glad001",
             "   AND glac001=glaa004",
             "   AND glaald=gladld",
             "   AND glacstus='Y'",
             "   AND glaastus='Y'",
             "   AND gladstus='Y'"
   
   PREPARE aglp030_glac_pre FROM l_sql
   EXECUTE  aglp030_glac_pre INTO l_count 
   
   IF l_count=0 OR cl_null(l_count) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "sub-01321" #"axm-00276"  #160318-00005#16 mod 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
  
   #160420-00001#9--add--str--
   LET l_count = 0 
   LET l_sql1="SELECT DISTINCT gladld,glad001 ",
              "  FROM glac_t,glaa_t,glad_t",
              " WHERE glacent='",g_enterprise,"'",
              "   AND ", g_wc CLIPPED,
              "   AND glacent=glaaent",
              "   AND glacent=gladent",
              "   AND glac002=glad001",
              "   AND glac001=glaa004",
              "   AND glaald=gladld",
              "   AND glacstus='Y'",
              "   AND glaastus='Y'",
              "   AND gladstus='Y'"
              
   LET l_sql="SELECT COUNT(*) FROM glaq_t,(",l_sql1,") a",
             " WHERE glaqent=",g_enterprise," AND glaqld=a.gladld AND glaq002=a.glad001"
   PREPARE aglp030_01_sel_glaq_pr FROM l_sql
   EXECUTE aglp030_01_sel_glaq_pr INTO l_count
   IF l_count = 0 THEN
      LET l_sql="SELECT COUNT(*) FROM glar_t,(",l_sql1,") a",
                " WHERE glarent=",g_enterprise," AND glarld=a.gladld AND glar001=a.glad001"
      PREPARE aglp030_01_sel_glar_pr FROM l_sql
      EXECUTE aglp030_01_sel_glar_pr INTO l_count
   END IF
   IF l_count > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ''
      LET g_errparam.code   = "agl-00443" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   #160420-00001#9--add--end
   
  
   IF cl_ask_confirm("agl-00308") THEN
      #更新
      CALL s_transaction_begin()
      LET l_success=TRUE
      
      LET l_sql="SELECT DISTINCT gladld,glad001 ",
                "  FROM glac_t,glaa_t,glad_t",
                " WHERE glacent='",g_enterprise,"'",
                "   AND ", g_wc CLIPPED,
                "   AND glacent=glaaent",
                "   AND glacent=gladent",
                "   AND glac002=glad001",
                "   AND glac001=glaa004",
                "   AND glaald=gladld",
                "   AND glacstus='Y'",
                "   AND glaastus='Y'",
                "   AND gladstus='Y'"
      
      PREPARE aglp030_01_selglad_pre FROM l_sql
      DECLARE aglp030_01_selglad_cur CURSOR FOR aglp030_01_selglad_pre

      FOREACH aglp030_01_selglad_cur INTO l_gladld,l_glad001
         LET l_gladcrtdt = cl_get_current() 

         UPDATE glad_t SET glad007=g_glad_m.glad007,glad008=g_glad_m.glad008,glad009=g_glad_m.glad009,
                           glad010=g_glad_m.glad010,glad011=g_glad_m.glad011,glad012=g_glad_m.glad012,
                           glad013=g_glad_m.glad013,glad015=g_glad_m.glad015,glad016=g_glad_m.glad016,
                           glad027=g_glad_m.glad027,glad031=g_glad_m.glad031,glad032=g_glad_m.glad032,
                           glad033=g_glad_m.glad033,glad030=g_glad_m.glad030,glad002=g_glad_m.glad002,
                           glad003=g_glad_m.glad003,glad004=g_glad_m.glad004,glad005=g_glad_m.glad005,
                           glad006=g_glad_m.glad006,glad036=g_glad_m.glad036,   #150814-00006#1 add glad036
                           glad034=g_glad_m.glad034,glad035=g_glad_m.glad035,   #150827-00036#7 add glad035  
                           glad017=g_glad_m.glad017,glad0171=g_glad_m.glad0171,glad0172=g_glad_m.glad0172,
                           glad018=g_glad_m.glad018,glad0181=g_glad_m.glad0181,glad0182=g_glad_m.glad0182,
                           glad019=g_glad_m.glad019,glad0191=g_glad_m.glad0191,glad0192=g_glad_m.glad0192,
                           glad020=g_glad_m.glad020,glad0201=g_glad_m.glad0201,glad0202=g_glad_m.glad0202,
                           glad021=g_glad_m.glad021,glad0211=g_glad_m.glad0211,glad0212=g_glad_m.glad0212,
                           glad022=g_glad_m.glad022,glad0221=g_glad_m.glad0221,glad0222=g_glad_m.glad0222,
                           glad023=g_glad_m.glad023,glad0231=g_glad_m.glad0231,glad0232=g_glad_m.glad0232,
                           glad024=g_glad_m.glad024,glad0241=g_glad_m.glad0241,glad0242=g_glad_m.glad0242,
                           glad025=g_glad_m.glad025,glad0251=g_glad_m.glad0251,glad0252=g_glad_m.glad0252,
                           glad026=g_glad_m.glad026,glad0261=g_glad_m.glad0261,glad0262=g_glad_m.glad0262,
                           gladmodid=g_user,gladmoddt=l_gladcrtdt
              WHERE gladent=g_enterprise
                AND gladld=l_gladld
                AND glad001=l_glad001                
        
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'upd glad_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success=FALSE
            EXIT FOREACH
         END IF 
         
      END FOREACH
      
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')                 
         RETURN
      ELSE
         CALL s_transaction_end('Y','1')
      END IF
            
   END IF      


END FUNCTION

 
{</section>}
 
