#adzp152 副程式 - action相關產生
# Modify........: No:YSC-E50003 14/05/14 By joyce 單頭串查功能調整
# Modify........: No:150529-00031 15/06/01 By joyce 單身串查功能需同時符合超連結與action點擊兩種方式

SCHEMA ds

GLOBALS
   DEFINE g_properties   om.SaxAttributes
   CONSTANT li_space = 3
   DEFINE g_component_list DYNAMIC ARRAY OF RECORD
            comp_id    STRING,
            action     LIKE type_t.num5,
            standard   LIKE type_t.num5,
            including  LIKE type_t.num5
            END RECORD
   DEFINE g_update     STRING   #YSC-E50004
END GLOBALS
# YSC-E50003 ---start---
DEFINE g_dzbb RECORD
         prog_name    STRING,
         point_name   STRING,
         point_ver    STRING,
         addpoint     STRING
         END RECORD
# YSC-E50003 --- end ---

#+ 產生 ON ACTION
PUBLIC FUNCTION adzp152_write_on_action(li_pos,p_type,ldnode_parent,p_loc,p_page)
   DEFINE p_loc           STRING                #所在位置
   DEFINE p_type          STRING                #樣板型態
   DEFINE p_page          STRING                #頁數
   DEFINE ldnode_parent   om.DomNode
   DEFINE ldnode_action   om.DomNode
   DEFINE li_cnt          LIKE type_t.num10
   DEFINE li_pos          LIKE type_t.num10     #空幾格
   DEFINE ls_m_action     STRING
   DEFINE ls_m_when       STRING
   DEFINE ls_single       STRING
   DEFINE ls_tmp          STRING
   DEFINE ls_m_action_bak STRING                #舊值備份 預防重複出現
   DEFINE ls_m_when_bak   STRING                #舊值備份 預防重複出現
   DEFINE ls_single_bak   STRING                #舊值備份 預防重複出現
   DEFINE ls_page         STRING
   DEFINE ls_name         STRING
   DEFINE ls_value        STRING

   #對3組主要的action置換變數先進行檢查,如果有值就先備份出來
   CALL adzp152_write_on_action_backup() RETURNING ls_m_action_bak,ls_m_when_bak,ls_single_bak

   #取得頁數代碼
   LET ls_page = p_page.trim()
   
   FOR li_cnt = 1 TO ldnode_parent.getChildCount()
      LET ldnode_action = ldnode_parent.getChildByIndex(li_cnt)
      IF ldnode_action.getTagName() <> "cluster" THEN    #YSC-E30002
      #  LET ls_tmp = adzp152_on_action(li_pos+1,ldnode_action,p_loc,ldnode_parent.getAttribute("page"))  #YSC-E50003 mark
         LET ls_tmp = adzp152_make_action(ldnode_action,p_loc,ldnode_parent.getAttribute("page"))         #YSC-E50003 add
         LET ls_single = ls_single, "\n",ls_tmp
      END IF
      
   END FOR

   CASE p_loc

      WHEN "menu"
         CALL g_properties.addAttribute("general_action_call",ls_single)
         LET ls_tmp = ls_single
         LET ls_tmp = cl_replace_str(ls_tmp,"EXIT DIALOG","EXIT MENU")
         LET ls_tmp = cl_replace_str(ls_tmp,"menu.","menu2.")
         CALL g_properties.addAttribute("general_action_call_in_menu",ls_tmp)

      WHEN "detail_show"
         IF ldnode_action.getTagName() <> "cluster" THEN    # add by joyce 14/03/18
            LET ls_name = "detail_saction_choice",ls_page
            LET ls_tmp = g_properties.getValue(ls_name)
            LET ls_tmp = ls_tmp, "\n", ls_single
            LET ls_value = ls_tmp
            CALL g_properties.addAttribute(ls_name,ls_value)
         END IF                                             # add by joyce 14/03/18

      WHEN "master_input"
         CALL g_properties.addAttribute("master_iaction_call",ls_single)

      WHEN "detail_input"
         LET ls_name = adzp152_create_name(ls_page, "detail_iaction_call", "<<<")
         LET ls_tmp = g_properties.getValue(ls_name)
         LET ls_tmp = ls_tmp, "\n", ls_single
         LET ls_value = ls_tmp
         CALL g_properties.addAttribute(ls_name,ls_value)
         
   END CASE

END FUNCTION

# YSC-E50003 ---start---
#+ 產生action段落(讀取slice)
PUBLIC FUNCTION adzp152_make_action(pdnode_action,p_loc,ps_page)
   DEFINE pdnode_action   om.DomNode #action tag
   DEFINE ldnode_sub      om.DomNode #action tag(sub)
   DEFINE p_loc           STRING     #該action所在位置
   DEFINE ps_page         STRING     #該action所在page
   DEFINE ls_action_name  STRING     #action名稱
   DEFINE ls_tmp          STRING
   DEFINE ls_name         STRING
   DEFINE ls_value        STRING
   DEFINE ls_mode         STRING     #action類型
   DEFINE ls_prog         STRING     #action串查(程式名稱)
   DEFINE ls_para         STRING     #action串查(參數)
   DEFINE ls_chk          STRING     #action是否進行身分檢驗
   DEFINE ls_lib          STRING     #action串查(lib名稱)
   DEFINE ls_prog_type    STRING     #程式樣板
   DEFINE ls_return       STRING
   DEFINE ls_adp_name     STRING     #150529-00031


   #先抓action名稱&mode類型
   LET ls_action_name = pdnode_action.getAttribute("id")
   LET ls_mode        = pdnode_action.getAttribute("mode")
   LET ls_prog        = pdnode_action.getAttribute("prog")
   LET ls_lib         = pdnode_action.getAttribute("lib")
   LET ls_para        = pdnode_action.getAttribute("parameter")
   LET ls_chk         = pdnode_action.getAttribute("chk")
   LET ls_prog_type   = g_properties.getValue("type_id")
   
   #判斷是否為標準action 並填入 mdl_action_call
   LET ls_name  = "mdl_action_call"
   LET ls_value = ""
   IF ls_mode = "popup" THEN
      LET ldnode_sub = pdnode_action.getFirstChild()
      WHILE ldnode_sub IS NOT NULL
         LET ls_value = ls_value, adzp152_make_action(ldnode_sub,p_loc,ps_page||"_sub")
	 LET ldnode_sub = ldnode_sub.getNext()
      END WHILE
      CALL g_properties.addAttribute(ls_name,ls_value)
      LET ls_value = adzp152_make_slice("a44")
      LET ls_value = cl_replace_str(ls_value,"         ","               ")
   ELSE
      IF adzp152_standard_actions(ls_action_name) THEN
      #  LET ls_value = "CALL ",g_properties.getValue("app_id"),"_",ls_action_name,"()"           #YSC-E60001 mark
         LET ls_value = "CALL ",g_properties.getValue("general_prefix"),"_",ls_action_name,"()"   #YSC-E60001 modify
      ELSE
         LET ls_value = adzp152_parse_element(pdnode_action,1)
      END IF
   END IF
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #進行資料填入, mdl_action_name
   LET ls_name  = "mdl_action_name"
   LET ls_value = ls_action_name
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #mdl_modify_detail (只有modify需要)
   LET ls_name  = "mdl_modify_detail"
   IF ls_action_name = "modify" THEN
      LET ls_value = "LET g_aw = ''"
   ELSE
      LET ls_value = "#該樣板不需此段落"
   END IF
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #判斷所在位置並(mdl_action_loc)決定離開時的名稱(mdl_exit)
   LET ls_name = "mdl_action_loc"
   CASE p_loc
      WHEN "menu"
         LET ls_value = "menu"
      WHEN "master_input"
         LET ls_value = "input.master_input"
      WHEN "detail_show"
         LET ls_value = "menu.detail_show.page",ps_page
      WHEN "detail_input"
         LET ls_value = "input.detail_input.page",ps_page
   END CASE
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #mdl_exit
   LET ls_name = "mdl_exit"
   LET ls_value = ""
   CASE p_loc
      WHEN "menu"
         IF ls_action_name <> "query"  AND 
		    ls_action_name <> "delete" THEN
         #  LET ls_value = "EXIT DIALOG"
            LET ls_value = ""
         END IF
      WHEN "master_input"
         LET ls_value = "#該樣板不需此段落"
      WHEN "detail_show"
      #  LET ls_value = "EXIT DIALOG"
         LET ls_value = ""
      WHEN "detail_input"
         LET ls_value = "#該樣板不需此段落"
	  OTHERWISE
	     LET ls_value = "#該樣板不需此段落"
   END CASE
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #popup特殊處理
   LET ls_name = "mdl_action_mark"
   IF ls_mode = "popup" THEN
      LET ls_value = "#該樣板不需此段落"
   ELSE
      LET ls_value = ""
   END IF
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #確認是否要進行身分驗證(cl_auth_chk_act)
   LET ls_name = "mdl_chk_mark"
   IF ls_chk = 'N' AND NOT cl_null(ls_chk) THEN
      LET ls_value = "#該樣板不需此段落"
   ELSE
      LET ls_value = ""
   END IF
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   LET ls_return = adzp152_make_slice("a43")

   LET ls_adp_name =  g_properties.getValue("mdl_action_loc"),'.',g_properties.getValue("mdl_action_name")   #150529-00031

   #處理程式串查段落(若有定義prog)
   IF NOT cl_null(ls_prog) THEN
   #  CALL adzp152_make_prog_link(ls_prog,ls_para,p_loc||"."||ls_action_name)   #150529-00031
      CALL adzp152_make_prog_link(ls_prog,ls_para,ls_adp_name)
      #如果有menu2需額外填寫(i01,i05專用)
      IF (ls_prog_type = "i01" OR ls_prog_type = "i05" ) AND p_loc = 'menu' THEN
         CALL adzp152_make_prog_link(ls_prog,ls_para,"menu2."||ls_action_name)
      END IF
   END IF   
        
   #處理lib串查段落(若有定義prog)
   IF NOT cl_null(ls_lib) THEN
   #  CALL adzp152_make_lib_link(ls_lib,ls_para,p_loc||"."||ls_action_name)   #150529-00031 mark
      CALL adzp152_make_lib_link(ls_lib,ls_para,ls_adp_name)
      #如果有menu2需額外填寫(i01,i05專用)
      IF (ls_prog_type = "i01" OR ls_prog_type = "i05" ) AND p_loc = 'menu' THEN
         CALL adzp152_make_lib_link(ls_lib,ls_para,"menu2."||ls_action_name)
      END IF
   END IF   
		
   RETURN ls_return    

END FUNCTION
# YSC-E50003 --- end ---

# YSC-E50003 ---mark start---
#+ 產生單檔樣板的action段落
#PUBLIC FUNCTION adzp152_on_action(pi_pos,pdnode_action,p_loc,ps_page)
#  DEFINE pdnode_action   om.DomNode
#  DEFINE ldnode_sub      om.DomNode
#  DEFINE p_loc           STRING
#  DEFINE ps_page         STRING
#  DEFINE pi_pos          LIKE type_t.num10     #空幾格
#  DEFINE ls_single       STRING
#  DEFINE ls_tmp          STRING
#  DEFINE ls_name         STRING
#  DEFINE ls_action       STRING

#  LET ls_action = "ACTION "
#  
#  LET ls_single = ls_single,"\n",
#                  (li_space * (pi_pos-1) ) SPACES,"ON ",ls_action,pdnode_action.getAttribute("id"),"\n"
#                  
#  #新增add point段落
#  IF pdnode_action.getAttribute("id") <> "update_item" THEN
#     LET ls_single = ls_single,"\n",
#                     (li_space * pi_pos ) SPACES,"LET g_action_choice=\"",pdnode_action.getAttribute("id"),"\"\n",
#                     (li_space * pi_pos ) SPACES,"IF cl_auth_chk_act(\"",pdnode_action.getAttribute("id"),"\") THEN \n"
#     LET pi_pos = pi_pos + 1
#  END IF
#  
#  IF pdnode_action.getAttribute("id") = "detail_qrystr" AND
#     pdnode_action.getAttribute("mode") = "popup" THEN
#     LET ls_single = ls_single, (li_space * (pi_pos) ) SPACES, 
#                     "MENU \"\" ATTRIBUTE(STYLE=\"popup\")"
#     LET ldnode_sub = pdnode_action.getFirstChild()
#     WHILE ldnode_sub IS NOT NULL
#        LET ls_tmp = adzp152_on_action(pi_pos+2,ldnode_sub,p_loc,ps_page||"_sub")
#        LET ls_tmp = cl_replace_str(ls_tmp,'EXIT MENU','')
#        LET ls_tmp = cl_replace_str(ls_tmp,'EXIT DIALOG','')
#        LET ls_single = ls_single,"\n", ls_tmp

#        LET ldnode_sub = ldnode_sub.getNext()
#     END WHILE
#     LET ls_single = ls_single,"\n", (li_space * (pi_pos) ) SPACES,"END MENU\n"
#  END IF

#  IF pdnode_action.getAttribute("type") = "standard" THEN
#     # YSC-E30001 ---modify start---
#     #標準內含於樣板檔的段落,就不產生自己的程式段落了 (改用替換的方法)
#  #  IF NOT adzp152_standard_actions(pdnode_action.getAttribute("id")) THEN
#  #     display "調用標準action:",pdnode_action.getAttribute("id")
#  #     LET g_component_list[g_component_list.getLength()+1].comp_id = pdnode_action.getAttribute("id")
#  #     LET g_component_list[g_component_list.getLength()].standard = TRUE
#  #  END IF

#     IF adzp152_standard_actions(pdnode_action.getAttribute("id")) THEN
#        LET ls_tmp = (li_space * (pi_pos)) SPACES,"CALL ",g_properties.getValue("app_id"),"_",pdnode_action.getAttribute("id"),"()\n"
#     END IF
#     # YSC-E30001 --- modify end ---
#  ELSE
#     LET ls_tmp = adzp152_parse_element(pdnode_action,pi_pos)
#  END IF
#  
#  LET ls_single = ls_single,ls_tmp
#  
#  CASE p_loc
#     WHEN "menu"
#        LET ls_name = "menu"
#     WHEN "master_input"
#        LET ls_name = "input.master_input"
#     WHEN "detail_show"
#        LET ls_name = "menu.detail_show.page",ps_page
#     WHEN "detail_input"
#        LET ls_name = "input.detail_input.page",ps_page
#  END CASE
#  
#  
#  LET ls_single = ls_single, (li_space*(pi_pos)) SPACES, "#add-point:ON ACTION ",pdnode_action.getAttribute("id"),"\n",
#                             (li_space*(pi_pos)) SPACES, "{<point name=\"",ls_name,".",pdnode_action.getAttribute("id"),"\" />}","\n",
#                             (li_space*(pi_pos)) SPACES, "#END add-point\n"
#  
#  #調整browser顯示異常
#  CASE p_loc
#     WHEN "menu"
#        IF pdnode_action.getAttribute("id") <> "query" AND 
#           pdnode_action.getAttribute("id") <> "delete" THEN
#           LET ls_single = ls_single,(li_space * pi_pos) SPACES,"EXIT DIALOG\n"
#        END IF
#     WHEN "master_input"

#     WHEN "detail_show"
#        LET ls_single = ls_single,(li_space * pi_pos) SPACES,"EXIT DIALOG\n"
#     WHEN "detail_input"
#   
#  END CASE
#  
#  IF pdnode_action.getAttribute("id") <> "update_item" THEN
#     LET pi_pos = pi_pos - 1
#     LET ls_single = ls_single,(li_space * pi_pos ) SPACES,"END IF\n"
#  END IF

#  RETURN ls_single
#  
#END FUNCTION
# YSC-E50003 --- mark end ---

#+ 產生雙檔樣板的action段落(只有定義g_action_choice的值)
PUBLIC FUNCTION adzp152_on_action_m_action(pi_pos,pdnode_action,p_loc)
   DEFINE p_loc           STRING
   DEFINE ls_name         STRING
   DEFINE pdnode_action   om.DomNode
   DEFINE ldnode_child    om.DomNode
   DEFINE ldnode_subact   om.DomNode
   DEFINE pi_pos          LIKE type_t.num10     #空幾格
   DEFINE ls_memo         STRING
   DEFINE ls_submenu      STRING
   DEFINE ls_return       STRING
   
   #檢查action名稱是否有定義
   IF cl_null(pdnode_action.getAttribute("id")) THEN
      DISPLAY "ERROR:ACTION定義錯誤,請重新檢查!"
   END IF

   #基本項目 (ON ACTION訂出來)
   LET ls_return = (li_space * (pi_pos-1) ) SPACES,
                   "ON ACTION ",pdnode_action.getAttribute("id")
   #MEMO附加參考
   LET ls_memo = pdnode_action.getAttribute("memo")
   IF ls_memo IS NOT NULL THEN
      LET ls_return = ls_return,(li_space*2) SPACES,"#",ls_memo
   END IF
   LET ls_return = ls_return,"\n"

   #處理sub-menu的popup段落 (此處子節點有各式各樣)
   LET ldnode_child = pdnode_action.getFirstChild()

   WHILE ldnode_child IS NOT NULL

      #此處先處理 submenu 的部分, 其餘component部分歸屬於 when階段處理
      IF ldnode_child.getTagName() = "submenu" THEN
         CASE ldnode_child.getAttribute("mode")
            WHEN "popup"      #彈出式視窗的處理
               LET ls_submenu = "MENU \"\" ATTRIBUTE(STYLE=\"popup\") \n"
               LET ldnode_subact = ldnode_child.getFirstChild()
               WHILE ldnode_subact IS NOT NULL
                  LET ls_submenu = ls_submenu,"\n", adzp152_on_action_m_action(6,ldnode_subact,'all')
                  LET ldnode_subact = ldnode_subact.getNext()
               END WHILE
               LET ls_submenu = ls_submenu,"\n",
                                (li_space * (pi_pos+1) ) SPACES,"END MENU"

            WHEN "input"      #_i( )段落子功能的選取 (page未處理)

            WHEN "construct"  #_cs( )段落子功能的選取 (不允許page)

            OTHERWISE
               DISPLAY "ERROR:Action->submenu(",ldnode_child.getAttribute("mode"),")不存在!!"
         END CASE
      END IF
      LET ldnode_child = ldnode_child.getNext()
   END WHILE
   
   CASE p_loc
      WHEN "menu"
         LET ls_name = "menu"
      WHEN "master_input"
         LET ls_name = "input"
      WHEN "detail_show"
         LET ls_name = "menu"
      WHEN "detail_input"
         LET ls_name = "input"
   END CASE

   IF ls_submenu IS NOT NULL THEN
      LET ls_return = ls_return,(li_space * pi_pos ) SPACES,ls_submenu
   ELSE
      LET ls_return = ls_return,((li_space+1) * pi_pos ) SPACES,"LET g_action_choice=\"",pdnode_action.getAttribute("id"),"\"\n"

      LET ls_return = ls_return, ((li_space+1)*pi_pos) SPACES, "#add-point:ON ACTION ",pdnode_action.getAttribute("id"),"\n",
                                 ((li_space+1)*pi_pos) SPACES, "{<point name=\"",ls_name,".",pdnode_action.getAttribute("id"),"\" />}","\n",
                                 ((li_space+1)*pi_pos) SPACES, "#END add-point\n",
                                 ((li_space+1)*pi_pos) SPACES, "EXIT DIALOG \n"
      
   END IF
   RETURN ls_return
   
END FUNCTION


#+ 產生雙檔樣板的action段落(實際action執行的程式片段)
PUBLIC FUNCTION adzp152_on_action_m_when(pi_pos,pdnode_action,p_loc)
   DEFINE p_loc           STRING
   DEFINE pdnode_action   om.DomNode
   DEFINE ldnode_child    om.DomNode
   DEFINE ldnode_subact   om.DomNode
   DEFINE pi_pos          LIKE type_t.num10     #空幾格
   DEFINE ls_tmp          STRING
   DEFINE ls_memo         STRING
   DEFINE ls_submenu      STRING
   DEFINE ls_return       STRING

   #處理sub-menu的popup段落
   LET ldnode_child = pdnode_action.getFirstChild()

   IF ldnode_child IS NOT NULL THEN
      IF ldnode_child.getTagName() = "submenu" THEN
         #如果是submenu, 則是遞迴直接使用下階即可
         WHILE ldnode_child IS NOT NULL
            CASE ldnode_child.getAttribute("mode")
               WHEN "popup"      #彈出式視窗的處理
                  LET ldnode_subact = ldnode_child.getFirstChild()
                  WHILE ldnode_subact IS NOT NULL
                     LET ls_submenu = ls_submenu,"\n", adzp152_on_action_m_when(pi_pos,ldnode_subact,'all')
                     LET ldnode_subact = ldnode_subact.getNext()
                  END WHILE
                  LET ls_submenu = ls_submenu,"\n"

               WHEN "input"      #_i( )段落子功能的選取 (page未處理)

               WHEN "construct"  #_cs( )段落子功能的選取 (不允許page)

               OTHERWISE
                  DISPLAY "ERROR:Action->submenu(",ldnode_child.getAttribute("mode"),")不存在!!"
            END CASE
            LET ls_return = ls_submenu
            LET ldnode_child = ldnode_child.getNext()
         END WHILE
         RETURN ls_return
      END IF
   END IF

   #以下段落,處理pdnode_action是NULL, 或不是 submenu的
   LET ls_return =(li_space * (pi_pos-1) ) SPACES,"WHEN \"",pdnode_action.getAttribute("id"),"\""

   #說明資訊
   LET ls_memo = pdnode_action.getAttribute("memo")
   IF NOT cl_null(ls_memo) THEN
      LET ls_return = ls_return,(li_space * pi_pos ) SPACES, "#",ls_memo
   END IF

   LET ls_return = ls_return,"\n",
                  (li_space * pi_pos ) SPACES,"IF cl_auth_chk_act(\"",pdnode_action.getAttribute("id"),"\") THEN \n"

   #標準內含於樣板檔的段落,就不產生自己的程式段落了 (改用替換的方法)
   IF pdnode_action.getAttribute("type") = "standard" THEN
      # YSC-E30001 ---mark start---
   #  IF NOT adzp152_standard_actions(pdnode_action.getAttribute("id")) THEN
   #     display "調用標準action:",pdnode_action.getAttribute("id")
   #     LET g_component_list[g_component_list.getLength()+1].comp_id = pdnode_action.getAttribute("id")
   #     LET g_component_list[g_component_list.getLength()].standard = TRUE
   #  END IF
      # YSC-E30001 --- mark end ---
      LET ls_tmp = (li_space * (pi_pos+1)) SPACES,"CALL ",g_properties.getValue("app_id"),"_",pdnode_action.getAttribute("id"),"()\n"
   ELSE
      LET ls_tmp = adzp152_parse_element(pdnode_action,pi_pos+1)
   END IF
   
   LET ls_return = ls_return,ls_tmp
   
   #新增add point段落
   LET ls_return = ls_return, ((li_space+1)*li_space) SPACES, "#add-point:ON ACTION ",pdnode_action.getAttribute("id"),"\n",
                              ((li_space+1)*li_space) SPACES, "{<point name=\"dialog.",pdnode_action.getAttribute("id"),"\" />}","\n",
                              ((li_space+1)*li_space) SPACES, "#END add-point\n\n"
            
   LET ls_return = ls_return,(li_space * pi_pos ) SPACES,"END IF"

   RETURN ls_return
   
END FUNCTION

#+ 先把sax.Attribute內部的action資料搜出來並備份
PRIVATE FUNCTION adzp152_write_on_action_backup()
   DEFINE ls_m_action_bak   STRING
   DEFINE ls_m_when_bak     STRING
   DEFINE ls_single_bak     STRING

   RETURN ls_m_action_bak,ls_m_when_bak,ls_single_bak

END FUNCTION


#+ 確認該標準的action是否是定義成在樣板檔裡面就有的  Yes:不用組 FUNCTION xxx()
PRIVATE FUNCTION adzp152_standard_actions(ps_act_id) 

   DEFINE ps_act_id   STRING

   IF ps_act_id = "insert"    OR ps_act_id = "query"     OR 
      ps_act_id = "reproduce" OR ps_act_id = "modify"    OR 
      ps_act_id = "delete"    OR ps_act_id = "filter"    THEN

      # YSC-E30001 ---start---
      # 若action的type是standard的話，程式段組成時會多組CALL此FUNCTION的段落，
      # 但是q類的程式幾乎都是讓使用者自行去開發，不內含此FUNCTION的程式段，
      # 若是程式執行時去呼叫，反而會有問題
      CASE g_properties.getValue("type_id")
         WHEN "q01"
            IF ps_act_id ="insert" OR
               ps_act_id ="query"  OR
               ps_act_id ="delete"    THEN
               DISPLAY "WARNING:",g_properties.getValue("type_id"),"樣板中不含",ps_act_id,"功能"
               RETURN FALSE
            END IF

         WHEN "q04"
            IF ps_act_id ="insert" OR
               ps_act_id ="query"  OR
               ps_act_id ="delete"    THEN
               DISPLAY "WARNING:",g_properties.getValue("type_id"),"樣板中不含",ps_act_id,"功能"
               RETURN FALSE
            END IF
      END CASE
      # YSC-E30001 --- end ---
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF

END FUNCTION

#+ 組合多語言架構會用到的action
PUBLIC FUNCTION adzp152_update_item_action(p_loc,p_node) 
   DEFINE p_node          om.DomNode
   DEFINE p_loc           STRING
   DEFINE ls_type         STRING
   DEFINE ls_iaction_call STRING
   DEFINE ls_tmp          STRING
   DEFINE ls_page         STRING
   DEFINE li_idx          INTEGER
   DEFINE li_cnt          INTEGER
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   
   LET ls_type = p_node.getAttribute("type")
   
   #多語言才進行處理
   IF ls_type <> "lang" THEN
      RETURN
   END IF
   
   #針對各個欄位處理
   LET lst_token = base.StringTokenizer.create(p_node.getAttribute("field"), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
   
      #若為單頭
      IF p_loc = 'm' THEN
         RETURN 
      ELSE
      #若為單身
         #取得單身page所在
         LET li_cnt = g_properties.getValue("page")
         FOR li_idx = 1 TO li_cnt
            LET ls_tmp = "detail_field_loc",li_idx USING "<<<"
            LET ls_tmp = g_properties.getValue(ls_tmp)
            IF ls_tmp.getIndexOf(ls_token,1) > 0 THEN
               LET ls_page = li_idx USING "<<<"
               EXIT FOR
            END IF
         END FOR
         LET ls_iaction_call =  g_properties.getValue("detail_iaction_call"||ls_page),
                                "   ON ACTION update_item \n\n"

         CALL g_properties.addAttribute("detail_iaction_call"||ls_page,ls_iaction_call)
         RETURN    
      END IF
   END WHILE

END FUNCTION

#YSC-E50003 ---start---
#+ 產生串查段落(程式串查)
PUBLIC FUNCTION adzp152_make_prog_link(ps_prog,ps_para,ps_adp_name)
   DEFINE ps_prog         STRING
   DEFINE ps_para         STRING
   DEFINE ps_adp_name     STRING
   DEFINE ls_adp          STRING
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_token        STRING
   DEFINE ls_page_name    STRING
   DEFINE ls_name         STRING
   DEFINE ls_value        STRING
   DEFINE li_idx          INTEGER
   
   #填入mdl_prog(串查程式名稱)
   LET ls_name  = "mdl_prog"
   LET ls_value = ps_prog
   CALL g_properties.addAttribute(ls_name,ls_value)

   #150529-00031 ---modify start---
   #填入mdl_para(傳遞參數), 相關動作處理
   IF cl_null(ps_para) THEN
      LET ls_value = "#"
   ELSE
      LET ls_value = ""
   END IF
   LET ls_name  = "mdl_link_mark"
   CALL g_properties.addAttribute(ls_name,ls_value)
   #150529-00031 --- modify end ---

   #拆解並轉換
   LET li_idx = 1
   LET lst_token = base.StringTokenizer.create(adzp152_parse_para(ps_para), ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_name = adzp152_create_name(li_idx, "mdl_link_para", "<<<")
      #150529-00031 ---modify start---
      #因為q04樣板沒有dataset，所以後續在組傳入參數時可能會有問題(無法找到對應的index指標)，
      #所以若是q04樣板，則把該行mark起來，讓使用者自行調整
      IF g_properties.getValue("type_id") = "q04" THEN
         LET ls_value = "請自行調整傳入參數"
      ELSE
         LET ls_value = ls_token
      END IF
      #150529-00031 --- modify end ---
      CALL g_properties.addAttribute(ls_name,ls_value)
      
      LET li_idx = li_idx + 1
   END WHILE
   
   LET ls_name = "mdl_mdls"
   LET ls_value = (li_idx - 1) USING "<<<"
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   LET ls_adp = adzp152_make_slice("a41")
    
   #寫入adp
   LET g_dzbb.prog_name  = g_properties.getValue("app_id")
   LET g_dzbb.point_name = ps_adp_name
   LET g_dzbb.point_ver  = g_properties.getValue("general_adp_ver")
   LET g_dzbb.addpoint   = ls_adp
#  CALL adzp152_insert_addpoint(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint)        #YSC-E50004 mark
   CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))   #YSC-E50004 modify
   
END FUNCTION 

#+ 產生串查段落(lib串查)
PUBLIC FUNCTION adzp152_make_lib_link(ps_lib,ps_para,ps_adp_name)
   DEFINE ps_lib          STRING
   DEFINE ps_para         STRING
   DEFINE ps_adp_name     STRING
   DEFINE ls_adp          STRING
   DEFINE ls_name         STRING
   DEFINE ls_value        STRING
   
   #填入mdl_lib(串查lib名稱)
   LET ls_name  = "mdl_lib"
   LET ls_value = ps_lib
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   #填入mdl_para(串查參數)
   LET ls_name  = "mdl_para"
   LET ls_value = adzp152_parse_para(ps_para)
   CALL g_properties.addAttribute(ls_name,ls_value)
   
   LET ls_adp = adzp152_make_slice("a45")

   #寫入adp
   LET g_dzbb.prog_name  = g_properties.getValue("app_id")
   LET g_dzbb.point_name = ps_adp_name
   LET g_dzbb.point_ver  = g_properties.getValue("general_adp_ver")
   LET g_dzbb.addpoint   = ls_adp
#  CALL adzp152_insert_addpoint(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint)        #YSC-E50004 mark
   CALL cl_add_point_insert(g_dzbb.prog_name,g_dzbb.point_name,g_dzbb.point_ver,g_dzbb.addpoint,g_update,ARG_VAL(5))   #YSC-E50004 modify
   
END FUNCTION 

#+ 解析參數, 轉為實際欄位(變數)
PUBLIC FUNCTION adzp152_parse_para(ps_para)
   DEFINE ps_para         STRING
   DEFINE ls_para         STRING
   DEFINE ls_token        STRING
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_master_field STRING
   DEFINE ls_page_name    STRING
   
   #先取得單頭所有欄位
   LET ls_master_field = g_properties.getValue("master_all_field")

   #拆解並轉換
   LET lst_token = base.StringTokenizer.create(ps_para, ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      IF ls_master_field.getIndexOf(ls_token,1) THEN
         #先確定是否在單頭
         LET ls_para = ls_para, g_properties.getValue("master_var_title"),".",ls_token
      ELSE
         #若不在單頭則尋找單身
         LET ls_page_name = adzp152_find_page(ls_token,'')
         IF cl_null(ls_page_name) THEN
            #非單身欄位, 視為一般變數
            LET ls_para = ls_para, ls_token
         ELSE
            #單身欄位, 定義變數名稱
         #  LET ls_para = ls_para, adzp152_find_page(ls_token,''),".",ls_token   #150529-00031 mark
            LET ls_para = ls_para, adzp152_find_table_page(ls_token,''),".",ls_token
         END IF
      END IF

      IF lst_token.hasMoreTokens() THEN
         LET ls_para = ls_para, ','
      END IF
      
   END WHILE

   RETURN ls_para
   
END FUNCTION
#YSC-E50003 --- end ---




