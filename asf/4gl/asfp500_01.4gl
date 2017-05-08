#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp500_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-04-08 00:00:00), PR版次:0001(2014-04-10 13:58:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000122
#+ Filename...: asfp500_01
#+ Description: 錯誤資訊匯總
#+ Creator....: 00378(2014-04-08 14:05:31)
#+ Modifier...: 00378 -SD/PR- 00378
 
{</section>}
 
{<section id="asfp500_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
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
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gzza_d        RECORD
       sdocno LIKE type_t.chr500, 
   gzza001 LIKE type_t.chr20, 
   prog_desc LIKE type_t.chr500, 
   docno LIKE type_t.chr20, 
   stus LIKE type_t.chr10, 
   crtid LIKE type_t.chr20, 
   crtid_desc LIKE type_t.chr500, 
   crtdp LIKE type_t.chr10, 
   crtdp_desc LIKE type_t.chr500, 
   opendd LIKE type_t.dat, 
   postdd LIKE type_t.dat, 
   errno LIKE type_t.chr10, 
   errno_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_temp_idx           LIKE type_t.num5              #單身 所在筆數(暫存用)
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
TYPE type_prog_d            RECORD
                            sdocno         LIKE sfaa_t.sfaadocno,
                            prog           LIKE gzza_t.gzza001, 
                            prog_desc      LIKE type_t.chr50, 
                            docno          LIKE sfaa_t.sfaadocno, 
                            stus           LIKE sfaa_t.sfaastus, 
                            crtid          LIKE sfaa_t.sfaacrtid, 
                            crtid_desc     LIKE type_t.chr50,  
                            crtdp          LIKE sfaa_t.sfaacrtdp, 
                            crtdp_desc     LIKE type_t.chr50,
                            opendd         LIKE type_t.dat,
                            postdd         LIKE type_t.dat,                              
                            errno          LIKE gzze_t.gzze001,
                            err_desc       LIKE type_t.chr200
                            END RECORD 


#end add-point
 
DEFINE g_gzza_d          DYNAMIC ARRAY OF type_g_gzza_d
DEFINE g_gzza_d_t        type_g_gzza_d
 
 
DEFINE g_gzza001_t   LIKE gzza_t.gzza001    #Key值備份
 
 
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
 
{<section id="asfp500_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION asfp500_01(--)
   #add-point:input段變數傳入 name="input.get_var"
p_arr
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
   DEFINE p_arr          DYNAMIC ARRAY OF type_prog_d
   DEFINE l_cnt          LIKE type_t.num10
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_asfp500_01 WITH FORM cl_ap_formpath("asf","asfp500_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL cl_set_combo_scc_part('stus','13','A,C,D,E,F,G,I,M,N,O,P,R,S,W,X,Y,H,V')
   
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY p_arr TO s_detail1.* ATTRIBUTE(COUNT=l_cnt) 
      
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
      
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
      
         #add-point:ui_dialog段more_displayarray

         #end add-point
         
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before

            #end add-point
            NEXT FIELD CURRENT
      
         
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
            
         
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG


     CLOSE WINDOW w_asfp500_01
     
     RETURN






   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_gzza_d FROM s_detail1.*
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
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sdocno
            #add-point:BEFORE FIELD sdocno name="input.b.page1.sdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sdocno
            
            #add-point:AFTER FIELD sdocno name="input.a.page1.sdocno"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sdocno
            #add-point:ON CHANGE sdocno name="input.g.page1.sdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzza001
            #add-point:BEFORE FIELD gzza001 name="input.b.page1.gzza001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzza001
            
            #add-point:AFTER FIELD gzza001 name="input.a.page1.gzza001"
            #此段落由子樣板a05產生
            IF  g_gzza_d[g_detail_idx].gzza001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzza_d[g_detail_idx].gzza001 != g_gzza_d_t.gzza001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzza_t WHERE "||"gzza001 = '"||g_gzza_d[g_detail_idx].gzza001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzza001
            #add-point:ON CHANGE gzza001 name="input.g.page1.gzza001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD docno
            #add-point:BEFORE FIELD docno name="input.b.page1.docno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docno
            
            #add-point:AFTER FIELD docno name="input.a.page1.docno"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docno
            #add-point:ON CHANGE docno name="input.g.page1.docno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stus
            #add-point:BEFORE FIELD stus name="input.b.page1.stus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stus
            
            #add-point:AFTER FIELD stus name="input.a.page1.stus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stus
            #add-point:ON CHANGE stus name="input.g.page1.stus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crtid
            
            #add-point:AFTER FIELD crtid name="input.a.page1.crtid"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crtid
            #add-point:BEFORE FIELD crtid name="input.b.page1.crtid"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crtid
            #add-point:ON CHANGE crtid name="input.g.page1.crtid"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crtdp
            
            #add-point:AFTER FIELD crtdp name="input.a.page1.crtdp"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crtdp
            #add-point:BEFORE FIELD crtdp name="input.b.page1.crtdp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crtdp
            #add-point:ON CHANGE crtdp name="input.g.page1.crtdp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD opendd
            #add-point:BEFORE FIELD opendd name="input.b.page1.opendd"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD opendd
            
            #add-point:AFTER FIELD opendd name="input.a.page1.opendd"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE opendd
            #add-point:ON CHANGE opendd name="input.g.page1.opendd"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD postdd
            #add-point:BEFORE FIELD postdd name="input.b.page1.postdd"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD postdd
            
            #add-point:AFTER FIELD postdd name="input.a.page1.postdd"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE postdd
            #add-point:ON CHANGE postdd name="input.g.page1.postdd"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD errno
            
            #add-point:AFTER FIELD errno name="input.a.page1.errno"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD errno
            #add-point:BEFORE FIELD errno name="input.b.page1.errno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE errno
            #add-point:ON CHANGE errno name="input.g.page1.errno"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sdocno
            #add-point:ON ACTION controlp INFIELD sdocno name="input.c.page1.sdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzza001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzza001
            #add-point:ON ACTION controlp INFIELD gzza001 name="input.c.page1.gzza001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.docno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docno
            #add-point:ON ACTION controlp INFIELD docno name="input.c.page1.docno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stus
            #add-point:ON ACTION controlp INFIELD stus name="input.c.page1.stus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.crtid
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crtid
            #add-point:ON ACTION controlp INFIELD crtid name="input.c.page1.crtid"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.crtdp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crtdp
            #add-point:ON ACTION controlp INFIELD crtdp name="input.c.page1.crtdp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.opendd
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD opendd
            #add-point:ON ACTION controlp INFIELD opendd name="input.c.page1.opendd"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.postdd
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD postdd
            #add-point:ON ACTION controlp INFIELD postdd name="input.c.page1.postdd"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.errno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD errno
            #add-point:ON ACTION controlp INFIELD errno name="input.c.page1.errno"
            
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_asfp500_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asfp500_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asfp500_01.other_function" readonly="Y" >}

 
{</section>}
 
