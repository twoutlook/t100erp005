#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi303.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-08-15 09:59:52), PR版次:0004(2016-11-07 14:31:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: azzi303
#+ Description: 報表樣板語言別轉換作業
#+ Creator....: 04010(2014-07-24 16:43:57)
#+ Modifier...: 04010 -SD/PR- 04010
 
{</section>}
 
{<section id="azzi303.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: No.151102-00034#2 15/11/02 Cynthia  報表環境變數入資料庫
#+ Modifier...: No.161107-00015#1 15/11/02 Cynthia  開放azzi303各語系轉換  
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_log_ch_ok      base.Channel
DEFINE g_log_ch_err     base.Channel
DEFINE g_logfilepath    STRING          #Log Directory
DEFINE g_logokfile      STRING
DEFINE g_logerrfile     STRING

#UI變數
DEFINE gwin_curr        ui.Window
DEFINE gfrm_curr        ui.Form
DEFINE gdig_curr        ui.Dialog

DEFINE gt_start,gt_end  DATETIME HOUR TO SECOND


DEFINE g_mnt4rp_path    STRING              #MNT4RP路徑
DEFINE g_cover          LIKE type_t.chr1    #覆蓋否
DEFINE g_cust           LIKE type_t.chr1    #客製否
DEFINE g_lang_src       LIKE gzzy_t.gzzy001 #來源語言別
DEFINE g_lang_trans     LIKE gzzy_t.gzzy001 #轉換語言別
DEFINE g_choose         LIKE type_t.chr1    #選擇轉換類別
DEFINE g_gzgd001        LIKE gzgd_t.gzgd001 #報表元件代號
DEFINE g_gzgd002        LIKE gzgd_t.gzgd002 #樣板代號

#DEFINE g_log_ch         base.Channel
#DEFINE g_log_ch1        base.Channel
DEFINE g_msg            STRING 
#DEFINE g_title          INTEGER 
DEFINE g_mdir           STRING              #改用g_mnt4rp_path
DEFINE g_4rpid          LIKE gzgd_t.gzgd000 #樣板ID
DEFINE g_gzgd007        LIKE gzgd_t.gzgd007 #樣板名稱
DEFINE g_sys            LIKE gzde_t.gzde002 #單支樣板模組別 
DEFINE g_mod            INTEGER
DEFINE g_4rpfile        STRING              #檔案路徑
DEFINE g_find_cnt       INTEGER
DEFINE g_workcnt        LIKE type_t.num10   #選擇的模組個數 
DEFINE g_select         DYNAMIC ARRAY of RECORD    #右邊已選擇模組
          gzde_s          LIKE gzde_t.gzde002
                        END RECORD
                       
DEFINE g_disable        DYNAMIC ARRAY of RECORD    #左邊可選擇模組           
          gzde_d          LIKE gzde_t.gzde002
                        END RECORD                       
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzi303.main" >}
#+ 作業開始
MAIN
   #add-point:main段define

   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化
 
   #end add-point
 
   #add-point:SQL_define

   #end add-point
   #LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   #DECLARE azzi303_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi303 WITH FORM cl_ap_formpath("azz",g_code)
   
      #程式初始化
      CALL azzi303_init()
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #進入選單 Menu (='N')
      CALL azzi303_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_azzi303
   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzi303.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#+ 畫面資料初始化
PRIVATE FUNCTION azzi303_init()

   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   
   #系統環境變數
#   LET g_mnt4rp_path = FGL_GETENV("MNT4RP")             #151102-00034#2 mark
   LET g_mnt4rp_path = cl_rpt_get_env_global("MNT4RP")   #151102-00034#2 add
   
   #執行項目設定
   CALL cl_set_combo_lang("l_lang_src")
   CALL cl_set_combo_lang("l_lang_trans")
   
   #預設為群組
   LET g_choose = "1"
   CALL cl_set_comp_entry("l_gzgd001",FALSE)
   CALL cl_set_comp_entry("l_cust",FALSE)
   
   LET g_cover = "N"
   LET g_cust = "N"
 
   #列出模組
   CALL azzi303_unselected_init()
   
   #預設為繁體中文轉簡體中文
   LET g_lang_src = "zh_TW"
   LET g_lang_trans = "zh_CN"
   
END FUNCTION

#+ 功能選單
PRIVATE FUNCTION azzi303_ui_dialog()
   DEFINE l_mnt4rp_path   STRING    #MNT4RP dir
   DEFINE li_cnt          LIKE type_t.num5
   DEFINE i               LIKE type_t.num5
   DEFINE l_ac_d,l_ac_s   LIKE type_t.num5   
   DEFINE li_total        LIKE type_t.num5
   DEFINE l_action        STRING
   DEFINE ls_message      STRING
   DEFINE l_choose        LIKE type_t.chr1
   DEFINE lb_result       BOOLEAN
   DEFINE l_success       LIKE type_t.num5  #140814 add
   DEFINE l_success_m     DYNAMIC ARRAY OF LIKE type_t.num5  #140814 add
   DEFINE l_gzgd001_t     LIKE gzgd_t.gzgd001 #140815 add
   DEFINE l_gzde001       LIKE gzde_t.gzde001,
          l_gzde002       LIKE gzde_t.gzde002
   DEFINE l_sys           STRING 
   DEFINE l_sql           STRING
   
   #DEFINE ls_top          STRING              
   DEFINE ls_str          STRING              
   #DEFINE p_msg           STRING            

   LET l_mnt4rp_path = g_mnt4rp_path
   LET l_choose = g_choose
   
   
   WHILE TRUE
   
      #DIALOG ATTRIBUTE(UNBUFFERED,FIELD ORDER FORM)
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
         #mnt4rp_path:4rppath, l_lang_src:來源語系, l_lang_trans:轉換語系, l_choose:轉換種類選擇, l_gzgd001:報表元件代號
         INPUT g_mnt4rp_path,g_cover,g_cust,g_choose,g_gzgd001,g_lang_src,g_lang_trans FROM l_mnt4rp_path,l_cover,l_cust,l_choose,l_gzgd001,l_lang_src,l_lang_trans 
         ATTRIBUTE(WITHOUT DEFAULTS = TRUE)
            ON ACTION controlp INFIELD l_gzgd001
               ### GR報表元件 ### start ###
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "i"
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_gzgd001
               LET g_qryparam.where = "1=1"
               CALL q_gzgd001()
               LET g_gzgd001 = g_qryparam.return1
               LET g_gzgd002 = g_qryparam.return2
               LET g_cust = g_qryparam.return3
               DISPLAY g_gzgd001 TO formonly.l_gzgd001
               DISPLAY g_gzgd002 TO formonly.lbl_gzgd002
               DISPLAY g_cust TO formonly.l_cust
               ### GR報表元件 ### end ###
               CALL cl_set_comp_entry("l_cust",FALSE)
               LET l_gzgd001_t = g_gzgd001

            ON CHANGE l_lang_src
               #來源語言別和轉換語言別不可相同
               IF g_lang_src = g_lang_trans THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00691"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
                   
            ON CHANGE l_lang_trans
               #來源語言別和轉換語言別不可相同
               IF g_lang_src = g_lang_trans THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00691"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
            
            ON CHANGE l_choose
               #選擇模組       
               IF g_choose = '1' THEN
                     LET g_gzgd001 = ""
                     DISPLAY "" TO formonly.lbl_gzgd002
                     CALL cl_set_comp_entry("l_gzgd001",FALSE)
                     CALL cl_set_comp_entry("l_cust",FALSE)
                  
                     CALL azzi303_unselected_init()
                     CALL cl_set_act_visible("btn_selall",TRUE)
                     CALL cl_set_act_visible("btn_select",TRUE)
                     CALL cl_set_act_visible("btn_disable",TRUE)
                     CALL cl_set_act_visible("btn_disall",TRUE)                  
               ELSE
                     #單支樣板  
                     CALL cl_set_comp_entry("l_gzgd001",TRUE)
                     CALL cl_set_comp_entry("l_cust",TRUE)
                     CALL cl_set_act_visible("btn_selall",FALSE)
                     CALL cl_set_act_visible("btn_select",FALSE)
                     CALL cl_set_act_visible("btn_disable",FALSE)
                     CALL cl_set_act_visible("btn_disall",FALSE)

                     CALL g_select.clear()
                     CALL g_disable.clear()
               END IF
            
            AFTER FIELD l_gzgd001
               #檢查報表元件是否存在GR報表樣板主檔中
               SELECT COUNT(*) INTO li_cnt FROM gzgd_t WHERE gzgd001 = g_gzgd001
               IF li_cnt <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00692"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               
               IF g_choose = "2" THEN
                  #不是開窗選的 
                  IF g_gzgd001 <>  l_gzgd001_t THEN
                     CALL cl_set_comp_entry("l_cust",TRUE)
                     LET g_gzgd002 = NULL 
                  END IF                  
                  CALL cl_set_act_visible("btn_selall",FALSE)
                  CALL cl_set_act_visible("btn_select",FALSE)
                  CALL cl_set_act_visible("btn_disable",FALSE)
                  CALL cl_set_act_visible("btn_disall",FALSE)
                  CALL g_select.clear()
                  CALL g_disable.clear() 
               END IF              
                      
         END INPUT
 
         DISPLAY ARRAY g_disable TO s_disable.*   #左邊
             BEFORE DISPLAY
                CALL DIALOG.setCurrentRow("s_disable",l_ac_d)
                #IF g_choose = '2' THEN
                   #單支樣板  
                #   CALL cl_set_comp_entry("l_gzgd001",TRUE)
                #   CALL cl_set_act_visible("btn_selall",FALSE)
                #   CALL cl_set_act_visible("btn_select",FALSE)
                #   CALL cl_set_act_visible("btn_disable",FALSE)
                #   CALL cl_set_act_visible("btn_disall",FALSE)

                #   CALL g_select.clear()
                #   CALL g_disable.clear()
                #   CONTINUE WHILE
                #END IF
                
                IF l_choose<>g_choose THEN #OR g_choose <> "2" THEN
                   CALL azzi303_unselected_init()
                   LET l_choose = g_choose
                END IF
             
             BEFORE ROW
                LET l_ac_d = DIALOG.getCurrentRow("s_disable")

             ON ACTION btn_select   #select  
                LET l_action = "btn_select"
                EXIT DIALOG
         END DISPLAY

         DISPLAY ARRAY g_select TO s_select.*   #右邊
             BEFORE DISPLAY
                CALL DIALOG.setCurrentRow("s_select",l_ac_s)
                #IF g_choose = '2' THEN
                   #單支樣板  
                #   CALL cl_set_comp_entry("l_gzgd001",TRUE)
                #   CALL cl_set_act_visible("btn_selall",FALSE)
                #   CALL cl_set_act_visible("btn_select",FALSE)
                #   CALL cl_set_act_visible("btn_disable",FALSE)
                #   CALL cl_set_act_visible("btn_disall",FALSE)

                #   CALL g_select.clear()
                #   CALL g_disable.clear()
                #   CONTINUE WHILE
                #END IF                

             BEFORE ROW
                LET l_ac_s = DIALOG.getCurrentRow("s_select")

             ON ACTION btn_disable
                LET l_action = "btn_disable"
                EXIT DIALOG          
         END DISPLAY
 
         ON ACTION start_trans  #start transform 開始轉換
            LET l_action = "start_trans"
            EXIT DIALOG

         #ON ACTION OUTPUT     #查看記錄檔
         #   CALL GPRebuild_outmenu()
      
         ON ACTION btn_selall #選取全部
            IF l_choose <> g_choose THEN
               CALL azzi303_unselected_init()
               LET l_choose = g_choose
            END IF       
            LET l_action = "btn_selall"
            EXIT DIALOG

         ON ACTION btn_disall #刪除全部
            LET l_action = "btn_disall"
            EXIT DIALOG
         
         #ON ACTION view_progression_bar #查看編譯過程
         #   LET l_action = "progression_bar"
         #   EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG

      END DIALOG
      IF INT_FLAG THEN
         LET INT_FLAG = TRUE
         EXIT WHILE
      END IF
      CASE l_action
         WHEN "start_trans" #執行編譯
#            IF (g_lang_src = "zh_TW" AND  g_lang_trans = "zh_CN") OR (g_lang_src = "zh_CN" AND g_lang_trans = "zh_TW") THEN   161107-00015#1 mark
               LET gt_start = cl_get_current()       #開始轉換時間
               LET g_workcnt = g_select.getLength()  #取得選擇的模組個數
               IF g_choose = "1" THEN 
                  #模組
                  LET i = 0
                  FOR li_cnt = 1 TO g_workcnt 
                     #CALL azzi303_multi_lang_trans(g_select[li_cnt].gzde_s CLIPPED,"","","",g_lang_src,g_lang_trans ,g_cover) RETURNING l_success
                     CALL sadzp188_multilang_4rp(g_select[li_cnt].gzde_s CLIPPED,"","","",g_lang_src,g_lang_trans ,g_cover) RETURNING l_success
                     LET l_success_m[li_cnt] = l_success
                     #IF NOT l_success_m[li_cnt] THEN
                     #   LET i = i + 1
                     #   DISPLAY g_select[li_cnt].gzde_s,"模組轉換失敗" 
                     #END IF                   
                  END FOR  
                  #IF i > 0 THEN LET l_success = FALSE END IF
                  LET l_success = TRUE #140815 先不判斷模組別轉換                  
               ELSE 
                  #單支樣板
                  #抓取系統別
                  LET l_gzde001 = g_gzgd001
                  LET l_sql = "SELECT gzde002 FROM ds.gzde_t WHERE gzde001=?"
                  PREPARE azzi303_mod_4rp_sys_pr FROM l_sql
                  EXECUTE azzi303_mod_4rp_sys_pr USING l_gzde001 INTO l_gzde002
                  FREE  azzi303_mod_4rp_sys_pr
                  LET l_sys = l_gzde002
                  LET l_sys = l_sys.toLowerCase()
                  IF g_cust = "Y" THEN
                     LET l_sys = 'c',l_sys.subString(2,l_sys.getLength()) CLIPPED
                     LET g_sys = l_sys
                  ELSE
                     LET g_sys = l_sys
                  END IF                  
                  
                  #CALL azzi303_multi_lang_trans("",g_sys,g_gzgd001 CLIPPED,g_gzgd002 CLIPPED,g_lang_src,g_lang_trans ,g_cover) RETURNING l_success
                  CALL sadzp188_multilang_4rp("",g_sys,g_gzgd001 CLIPPED,g_gzgd002 CLIPPED,g_lang_src,g_lang_trans ,g_cover) RETURNING l_success
               END IF
               
               LET gt_end = cl_get_current()         #結束轉換時間 
         
               LET ls_message = "4rp Transform Finish. Total Spent Time:",gt_end - gt_start," \n\n",
                                "Detail Log File: ",g_logfilepath,"\n"
                                #,"Error File List: ",os.Path.join(FGL_GETENV("TEMPDIR"),"GRtrans_"||g_logr001 CLIPPED||"_errlist.log")
               DISPLAY ls_message
   

               IF l_success THEN 
                  #INITIALIZE g_errparam TO NULL
                  #LET g_errparam.code = "azz-00693"
                  #LET g_errparam.extend = ""
                  #LET g_errparam.popup = TRUE
                  #CALL cl_err()               
                  CALL cl_ask_confirm_parm("azz-00693","") RETURNING lb_result               
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00694"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()               
               END IF               
#161107-00015#1 nark(s)
#            ELSE   
#               LET ls_str = "目前只開放繁簡轉換，請重新選擇語言別"
#               DISPLAY ls_str TO formonly.l_display
#               CONTINUE WHILE            
#            END IF 
#161107-00015#1 nark(e)
            
         WHEN "btn_selall" #全部選取
            LET li_total = g_select.getLength()
            IF g_disable.getLength() > 0 THEN
               FOR li_cnt = 1 TO g_disable.getLength()
                  LET g_select[li_total + li_cnt].gzde_s = g_disable[li_cnt].gzde_d
               END FOR
               CALL g_disable.clear()
            END IF

         WHEN "btn_select" #選取本項 
            IF g_disable.getLength() >= 1 THEN    #module
               LET li_total = g_select.getLength()
               LET g_select[li_total + 1].gzde_s = g_disable[l_ac_d].gzde_d     #全部模組
               CALL g_disable.deleteElement(l_ac_d)
            END IF
 
         WHEN "btn_disable" #刪除本項
            IF g_select.getLength() >= 1 THEN
               LET li_total = g_disable.getLength()
               LET g_disable[li_total + 1].gzde_d = g_select[l_ac_s].gzde_s
               CALL g_select.deleteElement(l_ac_s)
            END IF

         WHEN "btn_disall" #刪除全部
            LET li_total = g_disable.getLength()
            IF g_select.getLength() > 0 THEN
               FOR li_cnt = 1 TO g_select.getLength()
                  LET g_disable[li_total + li_cnt].gzde_d = g_select[li_cnt].gzde_s
               END FOR
               CALL g_select.clear()
            END IF
         WHEN "progression_bar" #查看編譯過程
             #CALL GPRebuild_progression_bar()

      END CASE
   END WHILE  
END FUNCTION

PRIVATE FUNCTION azzi303_gzge_trans(p_lang1,p_lang2)
   DEFINE p_lang1      LIKE gzzy_t.gzzy001   #待轉的語言別
   DEFINE p_lang2      LIKE gzzy_t.gzzy001   #轉換的語言別

END FUNCTION

#取得左邊選單模組資料
PRIVATE FUNCTION azzi303_unselected_init()
   DEFINE ls_tmp1       STRING
   DEFINE ls_tmp2       STRING
   DEFINE tok           base.StringTokenizer
   DEFINE li_i          LIKE type_t.num10
   DEFINE li_workcnt    LIKE type_t.num10   
   DEFINE l_4rppath     STRING 
   
   
   DEFINE ls_path    STRING
   DEFINE ls_child   STRING
   DEFINE ls_return  STRING
   DEFINE li_h       LIKE type_t.num10
   DEFINE l_temp     STRING
   DEFINE l_workcnt  LIKE type_t.num10

   CALL g_select.clear()
   CALL g_disable.clear()

#   LET l_4rppath = FGL_GETENV("MNT4RP")             #151102-00034#2 mark
   LET l_4rppath = cl_rpt_get_env_global("MNT4RP")   #151102-00034#2 add
   LET li_i = g_disable.getLength()
       
   LET ls_return = ""
   LET l_workcnt = 0
   CALL os.Path.dirsort("name",1)
   LET li_h = os.Path.diropen(l_4rppath)
   LET li_i = 1 
   WHILE li_h > 0
      LET ls_child = os.Path.dirnext(li_h)
      IF ls_child IS NULL THEN EXIT WHILE END IF
      IF ls_child == "." OR ls_child == ".." THEN CONTINUE WHILE END IF
      LET ls_child = ls_child.trim()
      IF ls_child = "tmp" THEN
         CONTINUE WHILE
      END IF
      LET g_disable[li_i].gzde_d = ls_child
      LET li_i = li_i+1 
   END WHILE
   CALL os.Path.dirclose(li_h)
   
END FUNCTION

#end add-point
 
{</section>}
 
