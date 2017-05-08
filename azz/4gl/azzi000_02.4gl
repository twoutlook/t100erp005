#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi000_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-08-03 17:35:33), PR版次:0017(2016-12-28 10:54:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000171
#+ Filename...: azzi000_02
#+ Description: 使用者設定
#+ Creator....: 00413(2014-06-16 11:58:05)
#+ Modifier...: 01274 -SD/PR- 00845
 
{</section>}
 
{<section id="azzi000_02.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161220-00012#1  2016/12/20  By hjwang    判斷參數確定是否額外複寫gzxd
#161228-00003#1  2016/12/28  By hjwang    gzxs參數抓取相反
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS
   DEFINE g_notneed_labeltag   BOOLEAN
END GLOBALS
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gzxq_d        RECORD
       gzxq002 LIKE gzxq_t.gzxq002, 
   gzxq003 LIKE gzxq_t.gzxq003, 
   gzxq004 LIKE gzxq_t.gzxq004, 
   gzxq005 LIKE gzxq_t.gzxq005, 
   gzxq006 LIKE gzxq_t.gzxq006, 
   gzxq007 LIKE gzxq_t.gzxq007
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_parameter           DYNAMIC ARRAY OF RECORD
         id                  LIKE type_t.chr50,   #參數ID ( Action ID )
         comp                LIKE type_t.chr50,   #對應畫面檔元件(參數群組包起來的container)
         img                 LIKE type_t.chr200   #圖片路徑
                             END RECORD
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_gzxa007             LIKE gzxa_t.gzxa007
DEFINE g_gzxa009             LIKE gzxa_t.gzxa009
DEFINE g_gzxa010             LIKE gzxa_t.gzxa010
DEFINE g_gzxa016             LIKE gzxa_t.gzxa016
DEFINE g_gzxa017             LIKE gzxa_t.gzxa017
DEFINE g_gzxa017_t           LIKE gzxa_t.gzxa017
DEFINE g_gzxd002             LIKE gzxd_t.gzxd002
DEFINE g_gzxd002_old         LIKE gzxd_t.gzxd002
DEFINE g_gzxd002_2           LIKE gzxd_t.gzxd002
DEFINE g_boardtype           LIKE type_t.chr1

DEFINE g_html   STRING   #TinyMCE HTML editor test
#end add-point
 
DEFINE g_gzxq_d          DYNAMIC ARRAY OF type_g_gzxq_d
DEFINE g_gzxq_d_t        type_g_gzxq_d
 
 
DEFINE g_gzxq001_t   LIKE gzxq_t.gzxq001    #Key值備份
DEFINE g_gzxq002_t      LIKE gzxq_t.gzxq002    #Key值備份
 
 
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
 
{<section id="azzi000_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION azzi000_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_tabname
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
   DEFINE lc_gzcb005      LIKE gzcb_t.gzcb005
   DEFINE lc_gzcb006      LIKE gzcb_t.gzcb006
   DEFINE lc_gzcb007      LIKE gzcb_t.gzcb007
   DEFINE ls_gzxd002      LIKE gzxd_t.gzxd002
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE l_folder        om.DomNode
   DEFINE p_tabname       STRING  #要切換到的頁籤名稱
   DEFINE l_cnt           INTEGER
   DEFINE l_next_field     STRING
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi000_02 WITH FORM cl_ap_formpath("azz","azzi000_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   
   #在GDC模式下，Folder不套用lefttabs樣式
   IF ui.interface.getFrontEndName() == "GDC" THEN
      LET l_folder = lfrm_curr.findNode("Folder", "folder_1")
      IF l_folder IS NOT NULL THEN
         CALL l_folder.setAttribute("style", "")
      END IF
   END IF
   
   CALL azzi000_02_init()
   CALL azzi000_02_fill()
   
   SELECT COUNT(*) INTO l_cnt FROM gzxq_t WHERE gzxqent = g_enterprise AND gzxq001 = g_account
   IF l_cnt > 0 THEN
      CALL lfrm_curr.setElementHidden("s_detail1", FALSE)
      LET g_boardtype = '0'
   ELSE
      CALL lfrm_curr.setElementHidden("s_detail1", TRUE)
      LET g_boardtype = '1'
   END IF
      
   LET g_sql = "SELECT gzcb005, gzcb006, gzcb007 FROM gzcb_t WHERE gzcb001 = '118' AND gzcb002 = ?"
   PREPARE azzi000_02_gzcb_pre FROM g_sql
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_gzxq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            #依照SCC-118決定是否可挑選資料數
            IF NOT cl_null(g_gzxq_d[l_ac].gzxq003) THEN
               EXECUTE azzi000_02_gzcb_pre USING g_gzxq_d[l_ac].gzxq003 INTO lc_gzcb005, lc_gzcb006, lc_gzcb007
               IF lc_gzcb007 = "Y" THEN
                  CALL cl_set_comp_entry("gzxq006", TRUE)
               ELSE
                  CALL cl_set_comp_entry("gzxq006", FALSE)
               END IF
               IF cl_null(g_gzxq_d[l_ac].gzxq004) THEN
                  LET g_gzxq_d[l_ac].gzxq004 = lc_gzcb005
                  DISPLAY BY NAME g_gzxq_d[l_ac].gzxq004
               END IF
               IF cl_null(g_gzxq_d[l_ac].gzxq005) THEN
                  LET g_gzxq_d[l_ac].gzxq005 = lc_gzcb006
                  DISPLAY BY NAME g_gzxq_d[l_ac].gzxq005
               END IF
            END IF
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
 
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzxq002
            #add-point:BEFORE FIELD gzxq002 name="input.b.page1.gzxq002"
            IF cl_null(g_gzxq_d[l_ac].gzxq002) THEN
               LET g_gzxq_d[l_ac].gzxq002 = l_ac
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzxq002
            
            #add-point:AFTER FIELD gzxq002 name="input.a.page1.gzxq002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzxq002
            #add-point:ON CHANGE gzxq002 name="input.g.page1.gzxq002"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzxq003
            #add-point:BEFORE FIELD gzxq003 name="input.b.page1.gzxq003"
            IF cl_null(g_gzxq_d[l_ac].gzxq002) THEN
               LET g_gzxq_d[l_ac].gzxq002 = l_ac
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzxq003
            
            #add-point:AFTER FIELD gzxq003 name="input.a.page1.gzxq003"
            IF cl_null(g_gzxq_d[l_ac].gzxq003) THEN
               INITIALIZE g_gzxq_d[l_ac].* TO NULL
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzxq003
            #add-point:ON CHANGE gzxq003 name="input.g.page1.gzxq003"
            #給預設值
            IF NOT cl_null(g_gzxq_d[l_ac].gzxq003) THEN
               #依照SCC-118決定是否可挑選資料數
               EXECUTE azzi000_02_gzcb_pre USING g_gzxq_d[l_ac].gzxq003 INTO lc_gzcb005, lc_gzcb006, lc_gzcb007
               IF lc_gzcb007 = "Y" THEN
                  CALL cl_set_comp_entry("gzxq006", TRUE)
                  IF cl_null(g_gzxq_d[l_ac].gzxq006) THEN
                     LET g_gzxq_d[l_ac].gzxq006 = 4
                  END IF
               ELSE
                  CALL cl_set_comp_entry("gzxq006", FALSE)
                  LET g_gzxq_d[l_ac].gzxq006 = ""
               END IF
               DISPLAY BY NAME g_gzxq_d[l_ac].gzxq006
               IF cl_null(g_gzxq_d[l_ac].gzxq004) THEN
                  LET g_gzxq_d[l_ac].gzxq004 = lc_gzcb005
                  DISPLAY BY NAME g_gzxq_d[l_ac].gzxq004
               END IF
               IF cl_null(g_gzxq_d[l_ac].gzxq005) THEN
                  LET g_gzxq_d[l_ac].gzxq005 = lc_gzcb006
                  DISPLAY BY NAME g_gzxq_d[l_ac].gzxq005
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzxq004
            #add-point:BEFORE FIELD gzxq004 name="input.b.page1.gzxq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzxq004
            
            #add-point:AFTER FIELD gzxq004 name="input.a.page1.gzxq004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzxq004
            #add-point:ON CHANGE gzxq004 name="input.g.page1.gzxq004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzxq005
            #add-point:BEFORE FIELD gzxq005 name="input.b.page1.gzxq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzxq005
            
            #add-point:AFTER FIELD gzxq005 name="input.a.page1.gzxq005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzxq005
            #add-point:ON CHANGE gzxq005 name="input.g.page1.gzxq005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzxq006
            #add-point:BEFORE FIELD gzxq006 name="input.b.page1.gzxq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzxq006
            
            #add-point:AFTER FIELD gzxq006 name="input.a.page1.gzxq006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzxq006
            #add-point:ON CHANGE gzxq006 name="input.g.page1.gzxq006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzxq007
            #add-point:BEFORE FIELD gzxq007 name="input.b.page1.gzxq007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzxq007
            
            #add-point:AFTER FIELD gzxq007 name="input.a.page1.gzxq007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzxq007
            #add-point:ON CHANGE gzxq007 name="input.g.page1.gzxq007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzxq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzxq002
            #add-point:ON ACTION controlp INFIELD gzxq002 name="input.c.page1.gzxq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzxq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzxq003
            #add-point:ON ACTION controlp INFIELD gzxq003 name="input.c.page1.gzxq003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzxq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzxq004
            #add-point:ON ACTION controlp INFIELD gzxq004 name="input.c.page1.gzxq004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzxq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzxq005
            #add-point:ON ACTION controlp INFIELD gzxq005 name="input.c.page1.gzxq005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzxq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzxq006
            #add-point:ON ACTION controlp INFIELD gzxq006 name="input.c.page1.gzxq006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzxq007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzxq007
            #add-point:ON ACTION controlp INFIELD gzxq007 name="input.c.page1.gzxq007"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         AFTER INSERT
            IF cl_null(g_gzxq_d[l_ac].gzxq003) THEN
               CALL g_gzxq_d.deleteElement(l_ac)
            ELSE
               IF cl_null(g_gzxq_d[l_ac].gzxq004) THEN
                  NEXT FIELD gzxq004
               END IF
               IF cl_null(g_gzxq_d[l_ac].gzxq005) THEN
                  NEXT FIELD gzxq005
               END IF
            END IF
         ON ROW CHANGE
            IF cl_null(g_gzxq_d[l_ac].gzxq003) THEN
               CALL g_gzxq_d.deleteElement(l_ac)
            ELSE
               IF cl_null(g_gzxq_d[l_ac].gzxq004) THEN
                  NEXT FIELD gzxq004
               END IF
               IF cl_null(g_gzxq_d[l_ac].gzxq005) THEN
                  NEXT FIELD gzxq005
               END IF
            END IF
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      INPUT g_gzxa016, g_boardtype, g_gzxa009, g_gzxa010, g_gzxa007, g_gzxa017
       FROM gzxa_t.gzxa016, FORMONLY.board, gzxa_t.gzxa009, gzxa_t.gzxa010, gzxa_t.gzxa007, gzxa_t.gzxa017
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            #預設值
            IF cl_null(g_gzxa009) THEN
               LET g_gzxa009 = "0"
            END IF
         ON CHANGE board
            IF g_boardtype = "1" THEN
               #轉成系統預設
               CALL lfrm_curr.setElementHidden("s_detail1", TRUE)

               IF cl_ask_confirm("azz-00221") THEN
                  #CALL s_azzi000_gzxq_maintain("d", g_account)
                  CALL g_gzxq_d.clear()
               ELSE
                  LET g_boardtype = "0"
                  CALL lfrm_curr.setElementHidden("s_detail1", FALSE)
               END IF
               DISPLAY g_boardtype TO FORMONLY.board

            ELSE
               #轉成使用者設定, 先幫忙塞入值
               #CALL s_azzi000_gzxq_maintain("a", g_account)
               CALL lfrm_curr.setElementHidden("s_detail1", FALSE)
            END IF
            CALL azzi000_02_fill()
            
      END INPUT

      INPUT g_gzxd002_old,g_gzxd002, g_gzxd002_2
       FROM FORMONLY.gzxd002_old, gzxd_t.gzxd002, FORMONLY.gzxd002_2
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            #為了讓畫面上不要讓使用者按錯鍵
            CALL DIALOG.setActionActive("accept_us", FALSE)
            NEXT FIELD gzxd002_old
         AFTER INPUT
            CALL DIALOG.setActionActive("accept_us", TRUE)
         ON ACTION confirm
            #檢查必填欄位
            IF cl_null(g_gzxd002_old) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "azz-00257"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD gzxd002_old
            END IF  
            #檢查必填欄位
            IF cl_null(g_gzxd002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "azz-00213"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD gzxd002
            END IF            
            
            #檢查必填欄位
            IF cl_null(g_gzxd002_2) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "azz-00018"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD gzxd002_2
            END IF 
            
            #抓原始密碼出來驗證
            SELECT gzxd002 INTO ls_gzxd002 FROM gzxd_t
             WHERE gzxd001 = g_account
               AND gzxdent = g_enterprise
            
            IF cl_hashkey_user_decode(ls_gzxd002) != g_gzxd002_old THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "azz-00258"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD gzxd002_old
            END IF 
            
            #檢查二個輸入密碼是否相符
            IF g_gzxd002_2 != g_gzxd002 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "azz-00018"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD gzxd002_2
            END IF
            
            IF s_azzi801_chk_gzxd002(g_gzxd002, ls_gzxd002) THEN
               CALL azzi000_02_update_passwd()
            ELSE
               NEXT FIELD gzxd002
            END IF
            
            LET g_gzxd002_old = NULL
            LET g_gzxd002     = NULL
            LET g_gzxd002_2   = NULL
            NEXT FIELD gzxd002_old
      END INPUT

      INPUT g_html FROM html ATTRIBUTE(WITHOUT DEFAULTS)
         
         ON ACTION show
            DISPLAY g_html
      END INPUT
      
      BEFORE DIALOG
         #依據傳入的頁籤名稱，切換到指定的頁籤
         CASE p_tabname
            WHEN "homepage"
               NEXT FIELD board
            WHEN "map"
               NEXT FIELD gzxa009
            WHEN "language"
               NEXT FIELD gzxa010
            WHEN "organization"
               NEXT FIELD gzxa007
            WHEN "password"
               NEXT FIELD gzxd002
            WHEN "modify_phone"
               NEXT FIELD gzxa017
         END CASE
         
      ON ACTION homepage
         NEXT FIELD board
      ON ACTION map
         NEXT FIELD gzxa009
      ON ACTION language
         NEXT FIELD gzxa010
      ON ACTION organization
         NEXT FIELD gzxa007
      ON ACTION password
         NEXT FIELD gzxd002
      ON ACTION modify_phone
         NEXT FIELD gzxa017
      ON ACTION signature
      ON ACTION accept_us
         IF NOT cl_null(l_next_field := azzi000_02_validate()) THEN
            CALL DIALOG.nextField(l_next_field)
            CONTINUE DIALOG
         END IF
         CALL azzi000_02_update()
         ACCEPT DIALOG
      ON ACTION cancel_us
         IF azzi000_02_chk_req() THEN
            LET INT_FLAG = TRUE 
            EXIT DIALOG
         ELSE
            CONTINUE DIALOG
         END IF
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
   #清空欄位值
   LET g_gzxd002_old = NULL
   LET g_gzxd002     = NULL
   LET g_gzxd002_2   = NULL
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_azzi000_02 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzi000_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="azzi000_02.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 設定資料抓取
# Memo...........: 
# Usage..........: CALL azzi000_02_fill()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/06/16 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi000_02_fill()
   DEFINE li_cnt   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE l_cnt    INTEGER
   
   LET g_sql = "SELECT gzxa007, gzxa009, gzxa010, gzxa016, gzxa017 FROM gzxa_t",
               " WHERE gzxaent = '", g_enterprise, "' AND gzxa001 = '", g_account,"'"
   PREPARE azzi000_02_fill_gzxa_pre FROM g_sql
   EXECUTE azzi000_02_fill_gzxa_pre INTO g_gzxa007, g_gzxa009, g_gzxa010, g_gzxa016, g_gzxa017
   LET g_gzxa017_t = g_gzxa017
   
   SELECT COUNT(*) INTO l_cnt FROM gzxq_t WHERE gzxqent = g_enterprise AND gzxq001 = g_account   
   IF l_cnt == 0 THEN
      CALL s_azzi000_gzxq_fill('default') RETURNING ls_js
   ELSE
      CALL s_azzi000_gzxq_fill(g_account) RETURNING ls_js
   END IF   
   CALL util.JSON.parse(ls_js, g_gzxq_d)

END FUNCTION
################################################################################
# Descriptions...: 子程式初始化
# Memo...........: 
# Usage..........: CALL azzi000_02_init()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/06/16 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi000_02_init()
   DEFINE lc_gzxq003    LIKE gzxq_t.gzxq003
   DEFINE lc_gzcbl004   LIKE gzcbl_t.gzcbl004
   DEFINE ls_values     STRING
   DEFINE ls_descs      STRING
   DEFINE lc_gzzd003    LIKE gzzd_t.gzzd003
   DEFINE lc_gzzd005    LIKE gzzd_t.gzzd005

   CALL cl_load_4ad_formlevel("azzi001")

   LET g_sql = "SELECT gzxq003, gzcbl004 FROM gzxq_t",
               "  LEFT JOIN gzcbl_t ON gzxq003 = gzcbl002 AND gzcbl001 = '118' AND gzcbl003 = '",g_dlang,"'",
               " WHERE gzxqent = '", g_enterprise, "' AND gzxq001 = 'default'",
               " ORDER BY gzxq002"
   PREPARE azzi000_02_init_getgzxq_pre FROM g_sql
   DECLARE azzi000_02_init_getgzxq_curs CURSOR FOR azzi000_02_init_getgzxq_pre
   FOREACH azzi000_02_init_getgzxq_curs INTO lc_gzxq003, lc_gzcbl004
      LET ls_values = ls_values, lc_gzxq003, ","
      LET ls_descs = ls_descs, lc_gzcbl004, ","
   END FOREACH
   LET ls_values = ls_values.subString(1, ls_values.getLength()-1)
   LET ls_descs = ls_descs.subString(1, ls_descs.getLength()-1)
   CALL cl_set_combo_items("gzxq003", ls_values, ls_descs)
   CALL cl_set_combo_scc("gzxa009", "108")
   CALL cl_set_combo_items("gzxq_t.gzxq004", "1,2,3,4,5,6", "1,2,3,4,5,6")
   CALL cl_set_combo_items("gzxq_t.gzxq005", "1,2,3", "1,2,3")
   CALL cl_set_combo_lang("gzxa010")
   IF cl_auth_user_init() THEN
      CALL cl_set_combo_authed_site("gzxa007")
   END IF

   DISPLAY g_account TO gzxa_t.gzxa001

   LET g_parameter[1].id = "homepage"
   LET g_parameter[1].comp = "s_detail1"
   LET g_parameter[2].id = "map"
   LET g_parameter[2].comp = "grid_map"
   LET g_parameter[3].id = "language"
   LET g_parameter[3].comp = "grid_language"
   LET g_parameter[4].id = "organization"
   LET g_parameter[4].comp = "grid_organization"
   LET g_parameter[5].id = "password"
   LET g_parameter[5].comp = "grid_password"
   LET g_parameter[6].id = "signature"
   LET g_parameter[6].comp = "grid_signature"

   #160621-00020#1 首頁匯入的多語言42s, 不一定能符合使用者挑選的語言別, 所以動態轉換
   #子畫面Element元件較多, 多語言資料較少, 此方式比較快速(未來看情況). 但要處理標準/客製兩次
   LET g_sql = "SELECT gzzd003, gzzd005 FROM gzzd_t",
               " WHERE gzzd001 = ? AND gzzd002 = ? AND gzzd004 = ? AND gzzdstus = ?"
   PREPARE azzi000_02_init_multilang_s_pre FROM g_sql
   DECLARE azzi000_02_init_multilang_s_curs CURSOR FOR azzi000_02_init_multilang_s_pre
   FOREACH azzi000_02_init_multilang_s_curs USING 'azzi000_02', g_lang, 's', 'Y' INTO lc_gzzd003, lc_gzzd005
      CALL azzi000_02_set_comp_lang(lc_gzzd003, lc_gzzd005)
   END FOREACH

   LET g_sql = "SELECT gzzd003, gzzd005 FROM gzzd_t",
               " WHERE gzzd001 = ? AND gzzd002 = ? AND gzzd004 = ? AND gzzdstus = ?"
   PREPARE azzi000_02_init_multilang_c_pre FROM g_sql
   DECLARE azzi000_02_init_multilang_c_curs CURSOR FOR azzi000_02_init_multilang_c_pre
   FOREACH azzi000_02_init_multilang_c_curs USING 'azzi000_02', g_lang, 'c', 'Y' INTO lc_gzzd003, lc_gzzd005
      CALL azzi000_02_set_comp_lang(lc_gzzd003, lc_gzzd005)
   END FOREACH
END FUNCTION
################################################################################
# Descriptions...: 儲存使用者設定
# Memo...........: 
# Usage..........: CALL azzi000_02_update()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/06/16 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi000_02_update()
   DEFINE li_i        LIKE type_t.num5
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE li_error    BOOLEAN
   DEFINE lc_gzxa001  LIKE gzxa_t.gzxa001
   DEFINE ls_js       STRING

   #首頁功能
   LET ls_js = util.JSON.stringify(g_gzxq_d)
   CALL s_azzi000_gzxq_maintain('d', g_account)
   IF g_boardtype != '1' THEN
      CALL s_azzi000_gzxq_update(g_account, ls_js)
   END IF

   #地圖, 語言, 營運據點
   LET g_forupd_sql = "SELECT gzxa001 FROM gzxa_t WHERE gzxaent = ? AND gzxa001 = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE azzi000_02_gzxa_cl CURSOR FROM g_forupd_sql

   LET g_sql = "UPDATE gzxa_t SET gzxa007 = ?, gzxa009 = ?, gzxa010 = ?, gzxa016 = ?, gzxa017 = ? ",
               " WHERE gzxaent = ", g_enterprise USING "<<<<<<", " AND gzxa001 = '", g_account,"'"
   PREPARE azzi000_02_gzxa_upd_pre FROM g_sql

   CALL s_transaction_begin()
   OPEN azzi000_02_gzxa_cl USING g_enterprise,g_account
   IF STATUS THEN
      CLOSE azzi000_02_gzxa_cl
      CALL s_transaction_end('N','0')    #161220-00012#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "azz-00212"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
   ELSE
      #鎖住將被更改或取消的資料
      FETCH azzi000_02_gzxa_cl INTO lc_gzxa001
      IF SQLCA.sqlcode THEN
         CLOSE azzi000_02_gzxa_cl
         CALL s_transaction_end('N','0')    #161220-00012#1
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "azz-00212"
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      ELSE
         #修改資料
         EXECUTE azzi000_02_gzxa_upd_pre USING g_gzxa007, g_gzxa009, g_gzxa010, g_gzxa016, g_gzxa017
         IF SQLCA.sqlcode THEN
            CLOSE azzi000_02_gzxa_cl
            CALL s_transaction_end('N','0')    #161220-00012#1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "azz-00212"
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()
         ELSE
            CALL s_transaction_end('Y','0')
            CALL FGL_SETENV("LANG", g_gzxa010||".utf8")
            LET g_lang = g_gzxa010
            LET g_site = g_gzxa007
            SELECT gzzy003 INTO g_dlang FROM gzzy_t WHERE gzzy001 = g_lang
         END IF
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 修改使用者密碼
# Memo...........: 
# Usage..........: CALL azzi000_02_update_passwd()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/06/16 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi000_02_update_passwd()
   DEFINE lc_gzxd001   LIKE gzxd_t.gzxd001
   DEFINE lc_gzxd002   LIKE gzxd_t.gzxd002

   LET g_forupd_sql = "SELECT gzxd001 FROM gzxd_t WHERE gzxdent = ? AND gzxd001 = ? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE azzi000_02_update_passwd_cl CURSOR FROM g_forupd_sql

   CALL s_transaction_begin()
   OPEN azzi000_02_update_passwd_cl USING g_enterprise, g_account
   IF STATUS THEN
      CLOSE azzi000_02_update_passwd_cl
      CALL s_transaction_end('N','0')    #161220-00012#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "azz-00212"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
   ELSE
      #鎖住將被更改或取消的資料
      FETCH azzi000_02_update_passwd_cl INTO lc_gzxd001
      #資料被他人LOCK, 或是sql執行時出現錯誤
      IF SQLCA.sqlcode THEN
         CLOSE azzi000_02_update_passwd_cl
         CALL s_transaction_end('N','0')   #161220-00012#1
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "azz-00212"
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      ELSE
         #161220-00012#1 -start #161228-00003#1
         IF cl_get_para(g_enterprise,"","E-SYS-2010") IS NOT NULL AND cl_get_para(g_enterprise,"","E-SYS-2010") = "Y" THEN
            UPDATE gzxs_t SET gzxs002 = g_gzxd002
             WHERE gzxsent = g_enterprise AND gzxs001 = g_account
            IF SQLCA.SQLCODE THEN
               DISPLAY "upd gzxs:",SQLCA.SQLCODE,":",SQLERRMESSAGE
            END IF
         END IF
         #161220-00012#1 -end
         LET lc_gzxd002 = cl_hashkey_user_encode(g_gzxd002)
         #更新密碼後，將gzxd004設成'N'
         UPDATE gzxd_t SET gzxd002 = lc_gzxd002, gzxd004 = 'N'
          WHERE gzxdent = g_enterprise AND gzxd001 = g_account
         UPDATE gzxz_t SET gzxz004 = 'N'
          WHERE gzxzent = g_enterprise AND gzxz001 = g_account
          
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               CALL s_transaction_end('N','0')    #161220-00012#1
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "gzxd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

            WHEN SQLCA.sqlcode #其他錯誤
               CALL s_transaction_end('N','0')    #161220-00012#1
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "gzxd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
            OTHERWISE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "azz-00214"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('Y','0')
         END CASE
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查必填項目、必做的功能(改密碼...)
# Memo...........:
# Usage..........: CALL azzi000_02_chk_req
#                  RETURNING lr_result
# Input parameter: none
# Return code....: lr_result    BOOLEAN
# Date & Author..: 2014/10/31 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi000_02_chk_req()
   DEFINE l_gzxd004     LIKE gzxd_t.gzxd004
   DEFINE l_gzxz004     LIKE gzxz_t.gzxz004
   
   #檢查是否必須更改密碼
   SELECT gzxd004 INTO l_gzxd004 FROM gzxd_t WHERE gzxdent = g_enterprise AND gzxd001 = g_account
   SELECT gzxz004 INTO l_gzxz004 FROM gzxz_t WHERE gzxzent = g_enterprise AND gzxz001 = g_account
         
   IF l_gzxd004 == "Y" OR l_gzxz004 == "Y" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00115"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF   
   
END FUNCTION

################################################################################
# Descriptions...: 驗證一些欄位的規則
# Memo...........:
# Usage..........: CALL azzi000_02_validate()
#                  RETURNING 回传参数
# Input parameter: none
# Return code....: lr_next_field 要next field欄位
# Date & Author..: 2014/12/30 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi000_02_validate()
   DEFINE l_next_field  STRING
    
   #檢查電話欄位是否有重覆
   IF NOT cl_null(g_gzxa017) AND g_gzxa017 != g_gzxa017_t THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_gzxa017
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_gzxa017") THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00282" #電話號碼不可重複
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_next_field = "gzxa017"
      ELSE
         LET g_gzxa017_t = g_gzxa017         
      END IF
   END IF
   RETURN l_next_field
END FUNCTION
################################################################################
# Descriptions...: 動態轉換多語言
# Memo...........: 
# Usage..........: azzi000_02_set_comp_lang(lc_gzzd003,lc_gzzd005)
# Input parameter: lc_gzzd003  待轉標籤(元件名)
#                : lc_gzzd005  標籤文字
# Return code....: None
# Date & Author..: 2016/06/21 By Saki
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi000_02_set_comp_lang(pc_gzzd003,pc_gzzd005)
   DEFINE pc_gzzd003 LIKE gzzd_t.gzzd003
   DEFINE pc_gzzd005 LIKE gzzd_t.gzzd005
   DEFINE lwin_curr  ui.Window
   DEFINE lfrm_curr  ui.Form
   DEFINE lnode_item, lnode_child om.DomNode
   DEFINE ls_value   STRING

   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()

   #部分元件無法直接使用setElementText(), 所以用以前的方式處理
   CASE
      WHEN pc_gzzd003 = "lbl_gzxa016"
         LET lnode_item = lfrm_curr.findNode("FormField", "gzxa_t.gzxa016")
         IF lnode_item IS NOT NULL THEN
            LET lnode_child = lnode_item.getFirstChild()
            IF lnode_child IS NOT NULL THEN
               CALL lnode_child.setAttribute("text", pc_gzzd005)
            END IF
         END IF
      WHEN pc_gzzd003 MATCHES "lbl_board_*"
         LET ls_value = pc_gzzd003
         LET ls_value = ls_value.subString(11, ls_value.getLength())
         LET lnode_item = lfrm_curr.findNode("FormField", "formonly.board")
         IF lnode_item IS NOT NULL THEN
            LET lnode_child = lnode_item.getFirstChild()
            IF lnode_child IS NOT NULL THEN
               LET lnode_item = lnode_child.getFirstChild()
               WHILE lnode_item IS NOT NULL
                  IF lnode_item.getAttribute("name") = ls_value THEN
                     CALL lnode_item.setAttribute("text", pc_gzzd005)
                     EXIT WHILE
                  ELSE
                     LET lnode_item = lnode_item.getNext()
                  END IF
               END WHILE
            END IF
         END IF
      OTHERWISE
         CALL lfrm_curr.setElementText(pc_gzzd003, pc_gzzd005)
   END CASE
END FUNCTION

 
{</section>}
 
