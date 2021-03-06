#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi160_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2013-08-29 11:34:28), PR版次:0002(2016-03-25 17:43:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000260
#+ Filename...: aooi160_01
#+ Description: 自動匯入匯率
#+ Creator....: 02298(2013-08-28 11:00:04)
#+ Modifier...: 02298 -SD/PR- 07900
 
{</section>}
 
{<section id="aooi160_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#30 2016/03/24 By 07900    重复错误信息修改
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
PRIVATE type type_g_ooam_m        RECORD
       ooam001 LIKE ooam_t.ooam001, 
   ooam001_desc LIKE type_t.chr80, 
   ooam003 LIKE ooam_t.ooam003, 
   ooam003_desc LIKE type_t.chr80, 
   ooam005 LIKE ooam_t.ooam005, 
   ooam004 LIKE ooam_t.ooam004, 
   ooam007 LIKE ooam_t.ooam007, 
   type LIKE type_t.chr500, 
   ratetype LIKE type_t.chr500, 
   excel LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_ooam_m        type_g_ooam_m
 
   DEFINE g_ooam001_t LIKE ooam_t.ooam001
DEFINE g_ooam003_t LIKE ooam_t.ooam003
DEFINE g_ooam004_t LIKE ooam_t.ooam004
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi160_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi160_01(--)
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
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_status       LIKE type_t.num5
   DEFINE l_excel        STRING 
   DEFINE ls_str         STRING
   DEFINE l_chr          LIKE type_t.chr1   
   DEFINE l_chr1         LIKE type_t.chr1 
   DEFINE l_chr2         LIKE type_t.chr5   
   DEFINE l_num          LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi160_01 WITH FORM cl_ap_formpath("aoo","aooi160_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET l_success = TRUE
   CALL cl_set_combo_scc('type','31')
   CALL cl_set_comp_visible("lbl_group1,lbl_group2",FALSE) 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_ooam_m.ooam001,g_ooam_m.ooam003,g_ooam_m.ooam005,g_ooam_m.ooam004,g_ooam_m.ooam007, 
          g_ooam_m.type,g_ooam_m.ratetype,g_ooam_m.excel ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            CALL cl_set_act_visible("download", FALSE)
            INITIALIZE g_ooam_m.* TO NULL
            LET g_ooam_m.ooam004 = g_today	
            LET g_ooam_m.ooam007 = 'N' 
            LET g_ooam_m.ooam005 = 1
            LET g_ooam_m.type = ''
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam001
            
            #add-point:AFTER FIELD ooam001 name="input.a.ooam001"
            #此段落由子樣板a05產生
          DISPLAY '' TO  ooam001_desc
            IF NOT cl_null(g_ooam_m.ooam001)  THEN
               CALL aooi160_01_ooal002_chk(1,g_ooam_m.ooam001)
               IF  NOT cl_null (g_errno)  THEN
                   IF g_errno = 'aoo-00076' THEN
                      IF NOT cl_ask_confirm('aoo-00076') THEN
                         LET g_ooam_m.ooam001 = ''
                         DISPLAY '' TO  ooam001_desc
                         NEXT FIELD ooam001
                      ELSE
                         CALL s_transaction_begin()
                         CALL s_aooi070_ins(1,g_ooam_m.ooam001) RETURNING l_success
                         IF l_success = TRUE THEN
                            CALL s_transaction_end('Y','1')
                         ELSE
                            CALL s_transaction_end('N','1')
                         END IF 
                      END IF 
                   ELSE
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = g_ooam_m.ooam001
                      #160318-00005#30  By 07900 --add-str
                      LET g_errparam.replace[1] ='aooi071'
                      LET g_errparam.replace[2] = cl_get_progname("aooi071",g_lang,"2")
                      LET g_errparam.exeprog ='aooi071'
                      #160318-00005#30  By 07900 --add-end
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET g_ooam_m.ooam001= g_ooam001_t
                      CALL aooi160_01_ooal002_desc(1,g_ooam_m.ooam001) RETURNING g_ooam_m.ooam001_desc
                      DISPLAY  BY NAME g_ooam_m.ooam001_desc  
                      NEXT FIELD ooam001
                   END IF
               END IF
            ELSE
               LET g_ooam_m.ooam001_desc = ''
            END  IF
           
            CALL aooi160_01_ooal002_desc(1,g_ooam_m.ooam001) RETURNING g_ooam_m.ooam001_desc
            DISPLAY BY NAME g_ooam_m.ooam001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam001
            #add-point:BEFORE FIELD ooam001 name="input.b.ooam001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam001
            #add-point:ON CHANGE ooam001 name="input.g.ooam001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam003
            
            #add-point:AFTER FIELD ooam003 name="input.a.ooam003"
            #此段落由子樣板a05產生
            DISPLAY '' TO ooam003_desc
            IF NOT cl_null(g_ooam_m.ooam003) THEN
               CALL aooi160_01_ooam003_chk(g_ooam_m.ooam003)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_ooam_m.ooam003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_ooam_m.ooam003 = ''
                  LET g_ooam_m.ooam003_desc=''
                  DISPLAY BY NAME g_ooam_m.ooam003_desc
                  NEXT FIELD ooam003	
               END IF 
            END IF 
            CALL aooi160_01_ooam003_desc(g_ooam_m.ooam003) RETURNING g_ooam_m.ooam003_desc
            DISPLAY BY NAME g_ooam_m.ooam003_desc



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam003
            #add-point:BEFORE FIELD ooam003 name="input.b.ooam003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam003
            #add-point:ON CHANGE ooam003 name="input.g.ooam003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooam_m.ooam005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD ooam005
            END IF 
 
 
 
            #add-point:AFTER FIELD ooam005 name="input.a.ooam005"
            IF NOT cl_null(g_ooam_m.ooam005) THEN
               IF g_ooam_m.ooam005 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = g_ooam_m.ooam005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD ooam005
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam005
            #add-point:BEFORE FIELD ooam005 name="input.b.ooam005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam005
            #add-point:ON CHANGE ooam005 name="input.g.ooam005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam004
            #add-point:BEFORE FIELD ooam004 name="input.b.ooam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam004
            
            #add-point:AFTER FIELD ooam004 name="input.a.ooam004"
            #此段落由子樣板a05產生
            



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam004
            #add-point:ON CHANGE ooam004 name="input.g.ooam004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam007
            #add-point:BEFORE FIELD ooam007 name="input.b.ooam007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam007
            
            #add-point:AFTER FIELD ooam007 name="input.a.ooam007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam007
            #add-point:ON CHANGE ooam007 name="input.g.ooam007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type
            #add-point:BEFORE FIELD type name="input.b.type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type
            
            #add-point:AFTER FIELD type name="input.a.type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type
            #add-point:ON CHANGE type name="input.g.type"
            IF g_ooam_m.type = 'A' THEN
               CALL cl_set_comp_visible("lbl_group1",TRUE)
               CALL cl_set_comp_visible ("lbl_group2",FALSE)
               CALL cl_set_act_visible("download", FALSE)
            ELSE
               CALL cl_set_comp_visible ("lbl_group2",TRUE)
               CALL cl_set_comp_visible ("lbl_group1",FALSE)
               CALL cl_set_act_visible("download",TRUE)
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ratetype
            #add-point:BEFORE FIELD ratetype name="input.b.ratetype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ratetype
            
            #add-point:AFTER FIELD ratetype name="input.a.ratetype"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ratetype
            #add-point:ON CHANGE ratetype name="input.g.ratetype"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD excel
            #add-point:BEFORE FIELD excel name="input.b.excel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD excel
            
            #add-point:AFTER FIELD excel name="input.a.excel"
            IF NOT cl_null(g_ooam_m.excel) THEN
               LET ls_str= ''
               LET l_chr2 = ''
               LET ls_str = g_ooam_m.excel
               LET l_num = ls_str.getlength()
               LET l_chr2 = ls_str.substring(l_num-2,l_num)
               IF l_chr2 <>'xls' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00260'
                  LET g_errparam.extend = g_ooam_m.excel
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD excel
               END IF 
            END IF    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE excel
            #add-point:ON CHANGE excel name="input.g.excel"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooam001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam001
            #add-point:ON ACTION controlp INFIELD ooam001 name="input.c.ooam001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooam_m.ooam001             #給予default值

            #給予arg

            CALL q_ooal002_3()                                #呼叫開窗

            LET g_ooam_m.ooam001 = g_qryparam.return1              #將開窗取得的值回傳到變數
             CALL aooi160_01_ooal002_desc(1,g_ooam_m.ooam001) RETURNING g_ooam_m.ooam001_desc
            DISPLAY BY NAME g_ooam_m.ooam001_desc
            DISPLAY g_ooam_m.ooam001 TO ooam001              #顯示到畫面上

            NEXT FIELD ooam001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooam003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam003
            #add-point:ON ACTION controlp INFIELD ooam003 name="input.c.ooam003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ooam_m.ooam003             #給予default值
            #給予arg
            CALL q_ooai001()                                       #呼叫開窗
            LET g_ooam_m.ooam003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aooi160_01_ooam003_desc(g_ooam_m.ooam003) RETURNING g_ooam_m.ooam003_desc
            DISPLAY BY NAME g_ooam_m.ooam003_desc
            DISPLAY g_ooam_m.ooam003 TO ooam003                    #顯示到畫面上
            NEXT FIELD ooam003                                     #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooam005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam005
            #add-point:ON ACTION controlp INFIELD ooam005 name="input.c.ooam005"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooam004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam004
            #add-point:ON ACTION controlp INFIELD ooam004 name="input.c.ooam004"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooam007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam007
            #add-point:ON ACTION controlp INFIELD ooam007 name="input.c.ooam007"
            
            #END add-point
 
 
         #Ctrlp:input.c.type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type name="input.c.type"
            
            #END add-point
 
 
         #Ctrlp:input.c.ratetype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ratetype
            #add-point:ON ACTION controlp INFIELD ratetype name="input.c.ratetype"
            
            #END add-point
 
 
         #Ctrlp:input.c.excel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD excel
            #add-point:ON ACTION controlp INFIELD excel name="input.c.excel"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      ON ACTION browser
         CALL cl_client_browse_file() RETURNING g_ooam_m.excel
         DISPLAY BY NAME g_ooam_m.excel
         LET ls_str= ''
         LET l_chr2 = ''
         LET ls_str = g_ooam_m.excel
         LET l_num = ls_str.getlength()
         LET l_chr2 = ls_str.substring(l_num-2,l_num)
         IF l_chr2 <>'xls' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aoo-00260'
            LET g_errparam.extend = g_ooam_m.excel
            LET g_errparam.popup = TRUE
            CALL cl_err()

            NEXT FIELD excel
         END IF 
         
      ON ACTION download
         CALL cl_client_browse_dir() RETURNING l_excel
         LET ls_str= ''
         LET l_chr = ''
         LET l_chr1 = ''
         LET ls_str = l_excel
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                        #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())    #判断是否为根目录
         IF l_chr <> l_chr1  THEN         
            LET l_excel = l_excel||l_chr||"exrate.xls"
         ELSE
            LET l_excel = l_excel||"exrate.xls"
         END IF
          IF NOT cl_null(l_excel) THEN         
             LET g_bgjob = 'Y'                  #add-mpp      
             LET status =  cl_client_download_file("$RES/std/exrate.xls",l_excel) 
             IF status THEN
                ERROR "Download OK!!"
             ELSE
                ERROR "Download fail!!"
             END IF         
          END IF    
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
   CLOSE WINDOW w_aooi160_01 
   
   #add-point:input段after input name="input.post_input"
   #取消  
   IF INT_FLAG THEN
      LET l_success = FALSE
      RETURN l_success
   END IF
   #确定
   CALL s_aooi160_ins(g_ooam_m.ooam001,g_ooam_m.ooam003,g_ooam_m.ooam005,g_ooam_m.ooam004,
                      g_ooam_m.ooam007,g_ooam_m.type,g_ooam_m.ratetype,g_ooam_m.excel ) 
   RETURNING l_success
   
   RETURN l_success   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi160_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi160_01.other_function" readonly="Y" >}
#+币别/汇率参照表号说明
PRIVATE FUNCTION aooi160_01_ooal002_desc(p_ooal001,p_ooal002)
   DEFINE p_ooal001     LIKE ooal_t.ooal001
   DEFINE p_ooal002     LIKE ooal_t.ooal002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooal001
   LET g_ref_fields[2] = p_ooal002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001=? AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION
#+参照表号说明
PRIVATE FUNCTION aooi160_01_ooal002_chk(p_ooal001,p_ooal002)
   DEFINE l_ooalstus    like ooal_t.ooalstus
   DEFINE p_ooal001     LIKE ooal_t.ooal001
   DEFINE p_ooal002     LIKE ooal_t.ooal002
   
   LET g_errno = ''
   SELECT ooalstus  INTO l_ooalstus
     FROM ooal_t 
    WHERE ooalent = g_enterprise
      AND ooal002 = p_ooal002
      AND ooal001 = p_ooal001
    CASE
       WHEN sqlca.sqlcode = 100   LET g_errno = 'aoo-00076'
       WHEN l_ooalstus ='N'  
        IF p_ooal001 = '1' THEN       
           LET g_errno = 'sub-01302' #aoo-00128  #160318-00005#30  By 07900 --mod
        ELSE
           LET g_errno = 'sub-01302' #aoo-00169  #160318-00005#30  By 07900 --mod
        END IF   
     END CASE
END FUNCTION
#币别说明
PRIVATE FUNCTION aooi160_01_ooam003_desc(p_ooam003)
   DEFINE p_ooam003    LIKE ooam_t.ooam003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooam003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION
#基础币别检查
PRIVATE FUNCTION aooi160_01_ooam003_chk(p_ooam003)
   DEFINE p_ooam003    LIKE ooam_t.ooam003
   DEFINE l_ooaistus   LIKE ooaj_t.ooajstus
   
   LET g_errno = ''
   SELECT ooaistus INTO l_ooaistus FROM ooai_t
    WHERE ooaient = g_enterprise
      AND ooai001 = p_ooam003

   IF SQLCA.SQLCODE = 100  THEN
      LET g_errno = 'aoo-00175'
   END IF
END FUNCTION

 
{</section>}
 
