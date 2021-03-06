#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi905_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-09-02 17:25:03), PR版次:0003(2016-09-14 16:57:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: aooi905_01
#+ Description: 委託第三方代收設定
#+ Creator....: 02003(2014-09-02 16:02:44)
#+ Modifier...: 02003 -SD/PR- 00700
 
{</section>}
 
{<section id="aooi905_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00007#9  2016/09/05  By 01531   调整系统中无ENT的SQL条件增加ent
#160908-00032#2  2016/09/14 By rainy    交易對象q_pmaa001()開窗改為q_pmaa001_4
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
PRIVATE type type_g_ooif_m        RECORD
       ooif003 LIKE ooif_t.ooif003, 
   ooif004 LIKE ooif_t.ooif004, 
   ooif004_desc LIKE type_t.chr80, 
   ooif005 LIKE ooif_t.ooif005, 
   ooif006 LIKE ooif_t.ooif006, 
   ooif007 LIKE ooif_t.ooif007
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooif000      LIKE ooif_t.ooif000
DEFINE g_ooif001       LIKE ooif_t.ooif001
DEFINE g_ooif009       LIKE ooif_t.ooif009
DEFINE g_ooif_m_t      type_g_ooif_m
#end add-point
 
DEFINE g_ooif_m        type_g_ooif_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi905_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi905_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ooif000,p_ooif001,p_ooif009 
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
   DEFINE p_ooif000      LIKE ooif_t.ooif000
   DEFINE p_ooif001       LIKE ooif_t.ooif001
   DEFINE p_ooif009       LIKE ooif_t.ooif009
   DEFINE l_ooifmodid     LIKE ooif_t.ooifmodid
   DEFINE l_ooifmoddt     DATETIME YEAR TO SECOND
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi905_01 WITH FORM cl_ap_formpath("aoo","aooi905_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_ooif000 = p_ooif000
   LET g_ooif001 = p_ooif001
   LET g_ooif_m.ooif003 = p_ooif009
   LET g_ooif_m.ooif007 = 'N'
   CALL aooi905_01_display()
   LET g_ooif_m_t.* = g_ooif_m.*
   LET l_ooifmodid = g_user
   LET l_ooifmoddt = cl_get_current()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_ooif_m.ooif003,g_ooif_m.ooif004,g_ooif_m.ooif005,g_ooif_m.ooif006,g_ooif_m.ooif007  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif003
            #add-point:BEFORE FIELD ooif003 name="input.b.ooif003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif003
            
            #add-point:AFTER FIELD ooif003 name="input.a.ooif003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif003
            #add-point:ON CHANGE ooif003 name="input.g.ooif003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif004
            
            #add-point:AFTER FIELD ooif004 name="input.a.ooif004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooif_m.ooif004
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooif_m.ooif004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooif_m.ooif004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif004
            #add-point:BEFORE FIELD ooif004 name="input.b.ooif004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif004
            #add-point:ON CHANGE ooif004 name="input.g.ooif004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif005
            #add-point:BEFORE FIELD ooif005 name="input.b.ooif005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif005
            
            #add-point:AFTER FIELD ooif005 name="input.a.ooif005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif005
            #add-point:ON CHANGE ooif005 name="input.g.ooif005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif006
            #add-point:BEFORE FIELD ooif006 name="input.b.ooif006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif006
            
            #add-point:AFTER FIELD ooif006 name="input.a.ooif006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif006
            #add-point:ON CHANGE ooif006 name="input.g.ooif006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooif007
            #add-point:BEFORE FIELD ooif007 name="input.b.ooif007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooif007
            
            #add-point:AFTER FIELD ooif007 name="input.a.ooif007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooif007
            #add-point:ON CHANGE ooif007 name="input.g.ooif007"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooif003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif003
            #add-point:ON ACTION controlp INFIELD ooif003 name="input.c.ooif003"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooif004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif004
            #add-point:ON ACTION controlp INFIELD ooif004 name="input.c.ooif004"
#此段落由子樣板a07產生            
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooif_m.ooif004             #給予default值

            #給予arg

            #CALL q_pmaa001()                         #呼叫開窗  #160908-00032#2 mark by rainy 
            CALL q_pmaa001_4()                        #呼叫開窗    #160908-00032#2 by rainy 開窗改為 q_pmaa001_4()

            LET g_ooif_m.ooif004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooif_m.ooif004 TO ooif004              #顯示到畫面上
            CALL aooi905_01_ooif011_desc()
            NEXT FIELD ooif004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.ooif005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif005
            #add-point:ON ACTION controlp INFIELD ooif005 name="input.c.ooif005"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooif006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif006
            #add-point:ON ACTION controlp INFIELD ooif006 name="input.c.ooif006"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooif007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooif007
            #add-point:ON ACTION controlp INFIELD ooif007 name="input.c.ooif007"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            CALL s_transaction_begin()    
            CALL cl_showmsg()   #錯誤訊息統整顯示

            UPDATE ooif_t SET (ooif004,ooif005,ooif006,ooif007,ooifmodid,ooifmoddt) = (g_ooif_m.ooif004,g_ooif_m.ooif005,g_ooif_m.ooif006,g_ooif_m.ooif007,l_ooifmodid,l_ooifmoddt)
             WHERE ooifent = g_enterprise AND ooif000 = g_ooif000 AND ooif001 = g_ooif001

            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ooif_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
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
   CLOSE WINDOW w_aooi905_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi905_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi905_01.other_function" readonly="Y" >}
#+ 資料顯示
PRIVATE FUNCTION aooi905_01_display()
   SELECT ooif004,ooif005,ooif006,ooif007
     INTO g_ooif_m.ooif004,g_ooif_m.ooif005,g_ooif_m.ooif006,g_ooif_m.ooif007 
     FROM ooif_t WHERE ooif000 = g_ooif000 AND ooif001 = g_ooif001
     AND ooifent = g_enterprise  #160905-00007#9  add
   DISPLAY BY NAME g_ooif_m.ooif004,g_ooif_m.ooif005,g_ooif_m.ooif006,g_ooif_m.ooif007
   CALL aooi905_01_ooif011_desc()   
   IF cl_null( g_ooif_m.ooif007) THEN 
      LET  g_ooif_m.ooif007 = 'N'
      DISPLAY BY NAME g_ooif_m.ooif007
   END IF
END FUNCTION
#+ 百分號格式轉換
PRIVATE FUNCTION aooi905_01_set_format(ps_fields,ps_format)
   DEFINE   ps_fields           STRING,
            ps_format           STRING
   DEFINE   lst_fields          base.StringTokenizer,
            ls_field_name       STRING
   DEFINE   lnode_root          om.DomNode,
            llst_items          om.NodeList,
            li_i                LIKE type_t.num5,
            lnode_item          om.DomNode,
            ls_item_name        STRING,
            lnode_item_child    om.DomNode,
            ls_item_child_tag   STRING
   DEFINE   lwin_curr           ui.Window

   IF (ps_fields IS NULL) THEN
      RETURN
   ELSE
      LET ps_fields = ps_fields.toLowerCase()
   END IF

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_root = lwin_curr.getNode()

   LET llst_items = lnode_root.selectByPath("//Form//*")
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
   WHILE lst_fields.hasMoreTokens()
      LET ls_field_name = lst_fields.nextToken()
      LET ls_field_name = ls_field_name.trim()

      FOR li_i = 1 TO llst_items.getLength()
         LET lnode_item = llst_items.item(li_i)
         LET ls_item_name = lnode_item.getAttribute("colName")

         IF (ls_item_name IS NULL) THEN
            LET ls_item_name = lnode_item.getAttribute("name")

            IF (ls_item_name IS NULL) THEN
               CONTINUE FOR
            END IF
         END IF

         IF (ls_item_name.equals(ls_field_name)) THEN
            LET lnode_item_child = lnode_item.getFirstChild()
            LET ls_item_child_tag = lnode_item_child.getTagName()
            IF (ls_item_child_tag.equals("Edit") OR
                ls_item_child_tag.equals("ButtonEdit") OR
                ls_item_child_tag.equals("Label") OR
                ls_item_child_tag.equals("DateEdit")) THEN

               CALL lnode_item_child.setAttribute("format", "")
               CALL lnode_item_child.setAttribute("format", ps_format)
            END IF

            EXIT FOR
         END IF
      END FOR
   END WHILE
END FUNCTION
#+ 代收機構名稱
PRIVATE FUNCTION aooi905_01_ooif011_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooif_m.ooif004
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooif_m.ooif004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooif_m.ooif004_desc
END FUNCTION

 
{</section>}
 
