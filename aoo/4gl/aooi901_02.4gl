#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi901_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-09-03 17:03:08), PR版次:0009(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000206
#+ Filename...: aooi901_02
#+ Description: 整批複製
#+ Creator....: 02295(2013-09-27 16:34:18)
#+ Modifier...: 02295 -SD/PR- 00000
 
{</section>}
 
{<section id="aooi901_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#33  2016/03/27   By 07900    重复错误信息修改
#160509-00004#42  2016/06/06   By 02114    增加ooie034,ooie035,ooie036,ooie039,ooie040栏位
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
PRIVATE type type_g_ooie_m        RECORD
       ooiesite_1 LIKE type_t.chr10, 
   ooiesite_1_desc LIKE type_t.chr80, 
   rtaa001_1 LIKE type_t.chr500, 
   rtaa001_1_desc LIKE type_t.chr80, 
   ooie001_1 LIKE type_t.chr10, 
   ooie001_1_desc LIKE type_t.chr80, 
   ooiesite_2 LIKE type_t.chr10, 
   ooiesite_2_desc LIKE type_t.chr80, 
   rtaa001_2 LIKE type_t.chr500, 
   rtaa001_2_desc LIKE type_t.chr80, 
   chk LIKE type_t.chr500, 
   ooie001_2 LIKE type_t.chr10, 
   ooie001_2_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooie_m_t        type_g_ooie_m
#end add-point
 
DEFINE g_ooie_m        type_g_ooie_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi901_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi901_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ooiesite,p_ooie001
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
   DEFINE p_ooiesite      LIKE ooie_t.ooiesite
   DEFINE p_ooie001       LIKE ooie_t.ooie001
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi901_02 WITH FORM cl_ap_formpath("aoo","aooi901_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"

   LET g_ooie_m.ooiesite_1 = p_ooiesite
   LET g_ooie_m.ooie001_1 = p_ooie001
   LET g_ooie_m.chk = 'N'
   LET g_ooie_m_t.* = g_ooie_m.* 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_ooie_m.ooiesite_1,g_ooie_m.rtaa001_1,g_ooie_m.ooie001_1,g_ooie_m.ooiesite_2,g_ooie_m.rtaa001_2, 
          g_ooie_m.chk,g_ooie_m.ooie001_2 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            CALL aooi901_02_display()
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiesite_1
            
            #add-point:AFTER FIELD ooiesite_1 name="input.a.ooiesite_1"
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_m.ooiesite_1
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_m.ooiesite_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_m.ooiesite_1_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiesite_1
            #add-point:BEFORE FIELD ooiesite_1 name="input.b.ooiesite_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooiesite_1
            #add-point:ON CHANGE ooiesite_1 name="input.g.ooiesite_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaa001_1
            
            #add-point:AFTER FIELD rtaa001_1 name="input.a.rtaa001_1"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_m.rtaa001_1
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_m.rtaa001_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_m.rtaa001_1_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaa001_1
            #add-point:BEFORE FIELD rtaa001_1 name="input.b.rtaa001_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaa001_1
            #add-point:ON CHANGE rtaa001_1 name="input.g.rtaa001_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie001_1
            
            #add-point:AFTER FIELD ooie001_1 name="input.a.ooie001_1"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_m.ooie001_1
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_m.ooie001_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_m.ooie001_1_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie001_1
            #add-point:BEFORE FIELD ooie001_1 name="input.b.ooie001_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie001_1
            #add-point:ON CHANGE ooie001_1 name="input.g.ooie001_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiesite_2
            
            #add-point:AFTER FIELD ooiesite_2 name="input.a.ooiesite_2"
            CALL aooi901_02_ooiesite_2_desc()


            IF NOT cl_null(g_ooie_m.ooiesite_2) THEN
               IF NOT ap_chk_notDup(g_ooie_m.ooiesite_2,"SELECT COUNT(*) FROM ooie_t WHERE "||"ooieent = '" ||g_enterprise|| "' AND "||"ooiesite = '"||g_ooie_m.ooiesite_2 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF            
               IF NOT ap_chk_isExist(g_ooie_m.ooiesite_2,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? ",'sub-01303',"aimi004") THEN  #aim-00010  #160318-00005#33 by 07900 --mod
                  LET g_ooie_m.ooiesite_2 = g_ooie_m_t.ooiesite_2 
                  NEXT FIELD CURRENT
               END IF  
               IF NOT ap_chk_isExist(g_ooie_m.ooiesite_2,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus = 'Y' ",'sub-01303',"aimi004") THEN   #aim-00010  #160318-00005#33 by 07900 --mod
                  LET g_ooie_m.ooiesite_2 = g_ooie_m_t.ooiesite_2 
                  NEXT FIELD CURRENT
               END IF 
               ##20150603--huangrh add--rtak               
               IF NOT ap_chk_isExist(g_ooie_m.ooiesite_2,"SELECT COUNT(*) FROM rtab_t,rtaa_t,rtak_t WHERE "||"rtabent = '" ||g_enterprise|| "' AND "||"rtab002 = ?  AND rtab001 = rtaa001 AND rtakent=rtaaent AND rtak001=rtaa001 AND rtak002='5' AND rtak003='Y' AND rtaastus = 'Y' ",'aoo-00377',0) THEN 
                  LET g_ooie_m.ooiesite_2 = g_ooie_m_t.ooiesite_2 
                  NEXT FIELD CURRENT
               END IF   
            END IF
            CALL aooi901_02_ooiesite_2_desc()           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiesite_2
            #add-point:BEFORE FIELD ooiesite_2 name="input.b.ooiesite_2"
            CALL aooi901_02_ooiesite_2_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooiesite_2
            #add-point:ON CHANGE ooiesite_2 name="input.g.ooiesite_2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaa001_2
            
            #add-point:AFTER FIELD rtaa001_2 name="input.a.rtaa001_2"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_m.rtaa001_2
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_m.rtaa001_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_m.rtaa001_2_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaa001_2
            #add-point:BEFORE FIELD rtaa001_2 name="input.b.rtaa001_2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaa001_2
            #add-point:ON CHANGE rtaa001_2 name="input.g.rtaa001_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.chk"
            IF g_ooie_m.chk = 'N' THEN 
               CALL cl_set_comp_entry("ooie001_2",TRUE)
            ELSE
               LET g_ooie_m.ooie001_2 = ''
               LET g_ooie_m.ooie001_2_desc = ''
               DISPLAY BY NAME g_ooie_m.ooie001_2,g_ooie_m.ooie001_2_desc
               CALL cl_set_comp_entry("ooie001_2",FALSE)
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie001_2
            
            #add-point:AFTER FIELD ooie001_2 name="input.a.ooie001_2"
            CALL aooi901_02_ooie001_2_desc()
            
            IF NOT cl_null(g_ooie_m.ooie001_2) THEN 
               IF NOT cl_null(g_ooie_m.ooiesite_2) THEN 
                  IF NOT ap_chk_notDup(g_ooie_m.ooie001_2,"SELECT COUNT(*) FROM ooie_t WHERE "||"ooieent = '" ||g_enterprise|| "' AND "||"ooiesite = '"||g_ooie_m.ooiesite_2 ||"' AND "|| "ooie001 = '"||g_ooie_m.ooie001_2 ||"'",'std-00004',0) THEN 
                     LET g_ooie_m.ooie001_2 = g_ooie_m_t.ooie001_2
                     NEXT FIELD CURRENT
                  END IF
               END IF            
               IF NOT ap_chk_isExist(g_ooie_m.ooie001_2,"SELECT COUNT(*) FROM ooia_t WHERE "||"ooiaent = '" ||g_enterprise|| "' AND "||"ooia001 = ? ",'aoo-00195',0) THEN 
                  LET g_ooie_m.ooie001_2 = g_ooie_m_t.ooie001_2
                  NEXT FIELD CURRENT
               END IF     
               IF NOT ap_chk_isExist(g_ooie_m.ooie001_2,"SELECT COUNT(*) FROM ooia_t WHERE "||"ooiaent = '" ||g_enterprise|| "' AND "||"ooia001 = ? AND ooiastus = 'Y' ",'sub-01302',"aooi713") THEN  #aoo-00196 #160318-00005#33 by 07900 --mod 
                  LET g_ooie_m.ooie001_2 = g_ooie_m_t.ooie001_2
                  NEXT FIELD CURRENT
               END IF   
            END IF  
            
            CALL aooi901_02_ooie001_2_desc()           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie001_2
            #add-point:BEFORE FIELD ooie001_2 name="input.b.ooie001_2"
            CALL aooi901_02_ooie001_2_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie001_2
            #add-point:ON CHANGE ooie001_2 name="input.g.ooie001_2"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooiesite_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiesite_1
            #add-point:ON ACTION controlp INFIELD ooiesite_1 name="input.c.ooiesite_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtaa001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaa001_1
            #add-point:ON ACTION controlp INFIELD rtaa001_1 name="input.c.rtaa001_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooie001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie001_1
            #add-point:ON ACTION controlp INFIELD ooie001_1 name="input.c.ooie001_1"
 
            #END add-point
 
 
         #Ctrlp:input.c.ooiesite_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiesite_2
            #add-point:ON ACTION controlp INFIELD ooiesite_2 name="input.c.ooiesite_2"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooie_m.ooiesite_2             #給予default值

            #給予arg

            CALL q_rtab002_01()                                #呼叫開窗

            LET g_ooie_m.ooiesite_2 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooie_m.ooiesite_2 TO ooiesite_2              #顯示到畫面上
            CALL aooi901_02_ooiesite_2_desc()
            
            NEXT FIELD ooiesite_2                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtaa001_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaa001_2
            #add-point:ON ACTION controlp INFIELD rtaa001_2 name="input.c.rtaa001_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooie001_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie001_2
            #add-point:ON ACTION controlp INFIELD ooie001_2 name="input.c.ooie001_2"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooie_m.ooie001_2             #給予default值

            #給予arg

            CALL q_ooia001_04()                                #呼叫開窗

            LET g_ooie_m.ooie001_2 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooie_m.ooie001_2 TO ooie001_2              #顯示到畫面上
            CALL aooi901_02_ooie001_2_desc()
            NEXT FIELD ooie001_2                          #返回原欄位


            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
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
   CLOSE WINDOW w_aooi901_02 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN 
      CALL aooi901_02_copy()
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi901_02.other_function" readonly="Y" >}
#+ 來源資料顯示
PRIVATE FUNCTION aooi901_02_display()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooie_m.ooiesite_1
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooie_m.ooiesite_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooie_m.ooiesite_1_desc
   
    SELECT DISTINCT rtaa001 INTO g_ooie_m.rtaa001_1 
    #20150603--huangrh add--rtak
      FROM rtab_t,rtaa_t,rtak_t
     WHERE rtabent = g_enterprise 
       AND rtaaent = rtabent
       AND rtaa001 = rtab001
       AND rtakent=rtaaent
       AND rtak001=rtaa001
       AND rtak002='5'
       AND rtak003='Y'     
       AND rtab002 = g_ooie_m.ooiesite_1
    DISPLAY BY NAME g_ooie_m.rtaa001_1
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooie_m.rtaa001_1
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooie_m.rtaa001_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooie_m.rtaa001_1_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooie_m.ooie001_1
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooie_m.ooie001_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooie_m.ooie001_1_desc
  
END FUNCTION
#+ 資料複製
PRIVATE FUNCTION aooi901_02_copy()
DEFINE l_ooie    RECORD 
   ooieent LIKE ooie_t.ooieent,
   ooiestus LIKE ooie_t.ooiestus,
   ooiesite LIKE ooie_t.ooiesite,
   ooie001 LIKE ooie_t.ooie001,
   ooie002 LIKE ooie_t.ooie002,
   ooie003 LIKE ooie_t.ooie003,
   ooie004 LIKE ooie_t.ooie004,
   ooie005 LIKE ooie_t.ooie005,
   ooie006 LIKE ooie_t.ooie006,
   ooie007 LIKE ooie_t.ooie007,
   ooie008 LIKE ooie_t.ooie008,
   ooie009 LIKE ooie_t.ooie009,
   ooie010 LIKE ooie_t.ooie010,
   ooie011 LIKE ooie_t.ooie011,
   ooie012 LIKE ooie_t.ooie012,
   ooie013 LIKE ooie_t.ooie013,
   ooie014 LIKE ooie_t.ooie014,
   ooie015 LIKE ooie_t.ooie015,
   ooie016 LIKE ooie_t.ooie016,
   ooie017 LIKE ooie_t.ooie017,
   ooie018 LIKE ooie_t.ooie018,
   ooie019 LIKE ooie_t.ooie019,
   ooie020 LIKE ooie_t.ooie020,
   ooie021 LIKE ooie_t.ooie021,
   ooie022 LIKE ooie_t.ooie022,
   ooie023 LIKE ooie_t.ooie023,
   ooie024 LIKE ooie_t.ooie024,
   ooie025 LIKE ooie_t.ooie025,
   ooie026 LIKE ooie_t.ooie026,
   ooie027 LIKE ooie_t.ooie027,   
   ooie028 LIKE ooie_t.ooie028,
   ooie029 LIKE ooie_t.ooie029,
   ooie030 LIKE ooie_t.ooie030,
   ooie031 LIKE ooie_t.ooie031,   #160215-00002#15 160509 by sakura add
   ooie032 LIKE ooie_t.ooie032,   #160215-00002#15 160509 by sakura add
   ooie033 LIKE ooie_t.ooie033,   #160215-00002#15 160509 by sakura add
   #160509-00004#42--add--str--lujh
   ooie034 LIKE ooie_t.ooie034,
   ooie035 LIKE ooie_t.ooie035,
   ooie036 LIKE ooie_t.ooie036,
   ooie039 LIKE ooie_t.ooie039,
   ooie040 LIKE ooie_t.ooie040,
   #160509-00004#42--add--end--lujh
   ooiepos LIKE ooie_t.ooiepos,   
   ooiestamp DATETIME YEAR TO FRACTION(5), 
   ooieownid LIKE ooie_t.ooieownid,
   ooieowndp LIKE ooie_t.ooieowndp,
   ooiecrtid LIKE ooie_t.ooiecrtid,
   ooiecrtdp LIKE ooie_t.ooiecrtdp,
   ooiecrtdt DATETIME YEAR TO SECOND,
   ooiemodid LIKE ooie_t.ooiemodid,
   ooiemoddt DATETIME YEAR TO SECOND   
      END RECORD
DEFINE l_sql     STRING
DEFINE l_success LIKE type_t.chr1

   CALL s_transaction_begin()
   LET l_success = 'Y'
   LET l_sql = " SELECT ooieent,ooiestus,ooiesite,ooie001,ooie002, ",  
               "        ooie003,ooie004,ooie005,ooie006,ooie007,   ",
               "        ooie008,ooie009,ooie010,ooie011,ooie012,   ",
               "        ooie013,ooie014,ooie015,ooie016,ooie017,   ",
               "        ooie018,ooie019,ooie020,ooie021,ooie022,   ",
               "        ooie023,ooie024,ooie025,ooie026,ooie027,   ",
               "        ooie028,ooie029,ooie030,ooie031,ooie032,   ",   #160215-00002#15 160509 by sakura ooie031~ooie33
               "        ooie033,ooie034,ooie035,ooie036,ooie039,   ",   #160509-00004#42 add ooie034,ooie035,ooie036,ooie039,ooie040 lujh
               "        ooie040,ooiepos,ooiestamp, ",
               "        ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,ooiecrtdt, ",
               "        ooiemodid,ooiemoddt  ",
               "   FROM ooie_t WHERE ooiesite = '",g_ooie_m.ooiesite_1,"'"

   IF g_ooie_m.chk = 'N' THEN 
      LET l_sql = l_sql," AND ooie001 = '",g_ooie_m.ooie001_1,"'"   
   END IF
   PREPARE ooie_copy_p FROM l_sql
   DECLARE ooie_copy_c CURSOR FOR ooie_copy_p
   FOREACH ooie_copy_c INTO l_ooie.*
      LET l_ooie.ooiesite = g_ooie_m.ooiesite_2
      IF g_ooie_m.chk = 'N' THEN
         LET l_ooie.ooie001 = g_ooie_m.ooie001_2
      END IF
      LET l_ooie.ooiestus ='Y'
      LET l_ooie.ooieownid = g_user
      LET l_ooie.ooieowndp = g_dept
      LET l_ooie.ooiecrtid = g_user
      LET l_ooie.ooiecrtdp = g_dept
      LET l_ooie.ooiecrtdt = cl_get_current()
      LET l_ooie.ooiemodid = g_user
      LET l_ooie.ooiemoddt = cl_get_current() 
      
      INSERT INTO ooie_t(ooieent,ooiestus,ooiesite,ooie001,ooie002,  
                         ooie003,ooie004,ooie005,ooie006,ooie007,   
                         ooie008,ooie009,ooie010,ooie011,ooie012,   
                         ooie013,ooie014,ooie015,ooie016,ooie017,   
                         ooie018,ooie019,ooie020,ooie021,ooie022,   
                         ooie023,ooie024,ooie025,ooie026,ooie027,   
                         ooie028,ooie029,ooie030,ooie031,ooie032,   #160215-00002#15 160509 by sakura add ooie031~ooie033
                         ooie033,ooie034,ooie035,ooie036,ooie039,   #160509-00004#42 add ooie034,ooie035,ooie036,ooie039,ooie040 lujh
                         ooie040,ooiepos,ooiestamp, 
                         ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,ooiecrtdt, 
                         ooiemodid,ooiemoddt) 
                  VALUES(l_ooie.ooieent,l_ooie.ooiestus,l_ooie.ooiesite,l_ooie.ooie001,l_ooie.ooie002,  
                         l_ooie.ooie003,l_ooie.ooie004,l_ooie.ooie005,l_ooie.ooie006,l_ooie.ooie007,   
                         l_ooie.ooie008,l_ooie.ooie009,l_ooie.ooie010,l_ooie.ooie011,l_ooie.ooie012,   
                         l_ooie.ooie013,l_ooie.ooie014,l_ooie.ooie015,l_ooie.ooie016,l_ooie.ooie017,   
                         l_ooie.ooie018,l_ooie.ooie019,l_ooie.ooie020,l_ooie.ooie021,l_ooie.ooie022,   
                         l_ooie.ooie023,l_ooie.ooie024,l_ooie.ooie025,l_ooie.ooie026,l_ooie.ooie027,   
                         l_ooie.ooie028,l_ooie.ooie029,l_ooie.ooie030,l_ooie.ooie031,l_ooie.ooie032,   #160215-00002#15 160509 by sakura add ooie031~ooie033
                         l_ooie.ooie033,l_ooie.ooie034,l_ooie.ooie035,l_ooie.ooie036,l_ooie.ooie039,   #160509-00004#42 add ooie034,ooie035,ooie036,ooie039,ooie040 lujh
                         l_ooie.ooie040,l_ooie.ooiepos,l_ooie.ooiestamp, 
                         l_ooie.ooieownid,l_ooie.ooieowndp,l_ooie.ooiecrtid,l_ooie.ooiecrtdp,l_ooie.ooiecrtdt, 
                         l_ooie.ooiemodid,l_ooie.ooiemoddt) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success = 'N'
         EXIT FOREACH
      END IF      
   END FOREACH
   IF l_success = 'N' THEN 
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')   
   END IF
   CLOSE ooie_copy_p
END FUNCTION
#+
PRIVATE FUNCTION aooi901_02_ooiesite_2_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_m.ooiesite_2
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_m.ooiesite_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_m.ooiesite_2_desc
            #20150603--huangrh add--rtak
            SELECT DISTINCT rtaa001 INTO g_ooie_m.rtaa001_2
              FROM rtab_t,rtaa_t,rtak_t
             WHERE rtabent = g_enterprise 
               AND rtaaent = rtabent
               AND rtaa001 = rtab001
               AND rtakent=rtaaent
               AND rtak001=rtaa001
               AND rtak002='5'
               AND rtak003='Y'
               AND rtab002 = g_ooie_m.ooiesite_2
            IF SQLCA.sqlcode =100 THEN
               LET g_ooie_m.rtaa001_2 = ''
            END IF 
            DISPLAY BY NAME g_ooie_m.rtaa001_2
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_m.rtaa001_2
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_m.rtaa001_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_m.rtaa001_2_desc
END FUNCTION
#+
PRIVATE FUNCTION aooi901_02_ooie001_2_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_m.ooie001_2
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_m.ooie001_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_m.ooie001_2_desc             
END FUNCTION

 
{</section>}
 
