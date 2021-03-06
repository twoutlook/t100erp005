#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: adzp153
#+ Buildtype: 
#+ Memo.....: 產生參數作業
# Modify.........:2014/07/08 By jrg542 在aoos010 畫面上要多一顆按鈕，固定產生在 『登入時是否需要產生驗證碼』後面 然後需要產生對應的 code (呼叫 saki 指定的 function s_azzi000_set_func(“default”) 
# Modify.........:2016/03/16 By jrg542 #151230-00007 #1.azzi993額外function需要存檔。(增加設定修改後追改功能gzsv008程式片段)
# Modify.........:2016/05/03 By jrg542 #160503-00009 #1.調整增加設定修改後追改功能程式片段位置改放在更新DB後
# Modify.........:2016/05/11 By jrg542 #160511-00003 #1.產生參數程式過程中出現編譯錯誤(修正 dzeb005='Y' 及 dzeb006 = '101')
# Modify.........:2017/01/17 By jrg542 #170117-00014 #1 ORDER BY gzsx004,gzsx005 改成 ORDER BY gzsx004,gzsx002,gzsx005,gzsx003                
# Modify.........:2017/01/24 By jrg542 #170124-00020 #1 調整參數產生器 針對據點級參數做處理，只要有據點級參數，可以有切換營運據點的開窗
# Modify.........:2017/02/10 By jrg542 #170210-00039 #1 增加密碼遮罩功能 目前只針對參數編號S-MFG-0062
IMPORT os
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 

DEFINE ms_module STRING  #模組編號
DEFINE ms_prog   STRING  #程式編號
DEFINE g_trans   DYNAMIC ARRAY OF RECORD
         tag     STRING,
         code    STRING
                 END RECORD
DEFINE g_gzsz    DYNAMIC ARRAY OF RECORD
         gzsv002  LIKE gzsv_t.gzsv002,          #分頁編號   #gzsz006
         gzsv003  LIKE gzsv_t.gzsv003,          #分項編號   #gzsz007 
         #pos     LIKE type_t.num5,             #本項序號
         gzsv004  LIKE gzsv_t.gzsv004,          #本項序號
         gzsv007  LIKE gzsv_t.gzsv007,          #設定額外檢查功能
         gzsv008  LIKE gzsv_t.gzsv008,          #設定修改後追改功能
         gzsz001  LIKE gzsz_t.gzsz001,          #表格編號  
         gzsz002  LIKE gzsz_t.gzsz002,          #參數編號
         gzsz003  LIKE gzsz_t.gzsz003,          #輸入型態
         gzsz008  LIKE gzsz_t.gzsz008,          #預設值
         gzsz009  LIKE gzsz_t.gzsz009,          #值域範圍
         gzsz013  LIKE gzsz_t.gzsz013,          #校驗
         gzsz014  LIKE gzsz_t.gzsz014,          #開窗
         gzsz016  LIKE gzsz_t.gzsz016           #值域範圍說明
                 END RECORD

CONSTANT li_space = 3
DEFINE gi_chk1   LIKE type_t.num5 
DEFINE gi_chk2   LIKE type_t.num5   
  
DEFINE g_gzsv    DYNAMIC ARRAY OF STRING        #170124-00020 #1


                 
MAIN
   DEFINE ls_code_filename STRING 
   DEFINE li_chk LIKE type_t.num5
   
   CALL cl_tool_init()

   #取得目前的環境代碼 由gens 這個shell 
   #DISPLAY "ARG_VAL(1):",ARG_VAL(1)
   #DISPLAY "ARG_VAL(2):",ARG_VAL(2)
   LET ms_module = DOWNSHIFT(ARG_VAL(1) CLIPPED)  #模組編號
   LET ms_prog   = DOWNSHIFT(ARG_VAL(2) CLIPPED)  #程式編號
   #查t100debug
   LET g_t100debug = FGL_GETENV("T100DEBUG")
   IF cl_null(ms_module) OR cl_null(ms_prog) THEN 
      DISPLAY "g_argv[1]:"
      DISPLAY "Error: 參數不足"
      DISPLAY "Example: r.r adzp153 模組編號 程式編號"
      CALL cl_ap_exitprogram("0")
   END IF 

   #傳進的參數是否是模組 不是模組的話就不繼續往下 
   IF NOT s_azzi900_chk_gzzj(UPSHIFT(ms_module)) THEN
      LET li_chk = FALSE 
      IF ms_prog.subString(1,1) = 'b' THEN 
         LET ms_module =  'a',ms_prog.subString(2,3)
         LET li_chk = s_azzi900_chk_gzzj(UPSHIFT(ms_module))  
       
      END IF 
      IF NOT li_chk THEN 
         DISPLAY "Error: 模組編號不存在:",ms_module
         CALL cl_ap_exitprogram("0")   
      END IF 
   END IF

   IF adzp153_chk_prog(ms_prog) THEN 
      DISPLAY "Error: 程式編號不存在:",ms_prog
      CALL cl_ap_exitprogram("0") 
   END IF 
   
   #代換程式資料準備
   CALL adzp153_data_prep()

   #進行程式碼轉換
   CALL adzp153_read_and_replace() RETURNING ls_code_filename
   #shell gens 指令complier及link

   CALL cl_ap_exitprogram("0")
END MAIN
 
#+ 代換資料的準備
PRIVATE FUNCTION adzp153_data_prep()

   DEFINE ls_sql  STRING
   DEFINE l_gzsx  DYNAMIC ARRAY OF RECORD
           #gzsx001                         #作業編號
           gzsx002 LIKE gzsx_t.gzsx002,     #分頁編號
           gzsx003 LIKE gzsx_t.gzsx003      #分項編號
           #gzsx004 LIKE gzsx_t.gzsx004     #分頁序號
                   END RECORD
   DEFINE li_cnt           LIKE type_t.num5
   DEFINE li_pos           LIKE type_t.num5
   DEFINE ls_colid         STRING           #欄位id
   DEFINE ls_temp          STRING
   DEFINE ls_temp_t        STRING
   DEFINE ls_temp2         STRING
   DEFINE li_layer,li_item LIKE type_t.num5
   DEFINE l_gzsx002_t      LIKE gzsx_t.gzsx002
   DEFINE li_bak           LIKE type_t.num5
   DEFINE li_only_once     LIKE type_t.num5
   DEFINE ls_table         STRING 
   DEFINE li_cnt2          LIKE type_t.num5   
   DEFINE ls_first_page    STRING   #第一預設分頁
   DEFINE li_total         LIKE type_t.num5
   DEFINE lc_gzsv001       LIKE gzsv_t.gzsv001
   DEFINE la_gzsz    DYNAMIC ARRAY OF RECORD
             gzsz001 LIKE gzsz_t.gzsz001
                     END RECORD
   DEFINE li_chk           LIKE type_t.num5

   #取得ooab_t 設定的參數程式
   CALL sadzp153_get_gzsv001(ms_prog) RETURNING g_gzsv
  
   #分頁,分項
   LET ls_sql = "SELECT gzsx002,gzsx003,gzsx004 FROM gzsx_t ",
                " WHERE gzsx001 = '",ms_prog.trim(),"' ",
                #" ORDER BY gzsx004,gzsx005 "
                " ORDER BY gzsx004,gzsx002,gzsx005,gzsx003 "  
   DECLARE adzp153_data_prep_cs CURSOR FROM ls_sql

   LET li_cnt = 1
   LET li_pos = 1
   LET li_layer = 0
   CALL g_trans.clear()
   LET l_gzsx002_t = " "

   #先定義tag
   LET g_trans[g_trans.getLength()+1].tag = "variable_list"         #1
   LET g_trans[g_trans.getLength()+1].tag = "field_list"            #2
   LET g_trans[g_trans.getLength()+1].tag = "on_action_help "       #3
   LET g_trans[g_trans.getLength()+1].tag = "before_field"          #4
   
   LET g_trans[g_trans.getLength()+1].tag = "btn_page"              #5
   LET g_trans[g_trans.getLength()+1].tag = "btn_page2"             #6
   LET g_trans[g_trans.getLength()+1].tag = "area_information"      #7
   LET g_trans[g_trans.getLength()+1].tag = "btn_paramsubgp"        #8

   LET g_trans[g_trans.getLength()+1].tag = "general_define_combo"  #9
   LET g_trans[g_trans.getLength()].code = " "
   
   #程式
   LET g_trans[g_trans.getLength()+1].tag = "prog"                  #10
   LET g_trans[g_trans.getLength()].code = ms_prog.trim()         
   #table id
   LET g_trans[g_trans.getLength()+1].tag = "tab_id"                #11
   CALL adzp153_get_table_info() RETURNING la_gzsz,g_trans[g_trans.getLength()].code
   LET ls_table = g_trans[g_trans.getLength()].code 
   #最大值 最小值 tag 定義
   LET g_trans[g_trans.getLength()+1].tag = "mdl_var"               #12   
   LET g_trans[g_trans.getLength()+1].tag = "mdl_min"               #13  
   LET g_trans[g_trans.getLength()+1].tag = "mdl_mintype"           #14      
   LET g_trans[g_trans.getLength()+1].tag = "mdl_max"               #15
   LET g_trans[g_trans.getLength()+1].tag = "mdl_maxtype"           #16
   LET g_trans[g_trans.getLength()+1].tag = "mdl_error"             #17
   LET g_trans[g_trans.getLength()+1].tag = "mdl_ow"                #18 
   LET g_trans[g_trans.getLength()+1].tag = "mdl_field"             #19 
 
   LET g_trans[g_trans.getLength()+1].tag = "var"                   #20
   LET g_trans[g_trans.getLength()+1].tag = "var_t"                 #21 
   LET g_trans[g_trans.getLength()+1].tag = "mdl"                   #22 
   LET g_trans[g_trans.getLength()+1].tag = "mdl_chkid"             #23 
   LET g_trans[g_trans.getLength()+1].tag = "extra_chk"             #24 
   LET g_trans[g_trans.getLength()+1].tag = "ps_field"              #25  

   LET g_trans[g_trans.getLength()+1].tag = "btn_controlp"          #26
   LET g_trans[g_trans.getLength()].code = " "
   LET g_trans[g_trans.getLength()+1].tag = "mdl_var1"              #27
   LET g_trans[g_trans.getLength()+1].tag = "mdl_form"              #28
   LET g_trans[g_trans.getLength()+1].tag = "mdl_field1"            #29
   LET g_trans[g_trans.getLength()+1].tag = "modify_after_chk"      #30 

   #aoos010 特別處理  
   #畫面上要多一顆按鈕，固定產生在 『登入時是否需要產生驗證碼』後面
   #然後需要產生對應的 code (呼叫 saki 指定的 function) s_azzi000_set_func(“default”)
   LET g_trans[g_trans.getLength()+1].tag = "btn_set_func"          #30
   LET g_trans[g_trans.getLength()].code = " "
   
   LET g_trans[g_trans.getLength()+1].tag = "general_module"
   LET g_trans[g_trans.getLength()].code = ms_module

   #g_ooaa_d
   LET g_trans[g_trans.getLength()+1].tag = "detail_var_title"
   LET g_trans[g_trans.getLength()].code = "g_",ls_table.subString(1,4),"_d" 

   #field info
   CALL adzp153_get_field_info(ls_table) RETURNING ls_temp,ls_temp2
   LET g_trans[g_trans.getLength()+1].tag = "detail_fields_define"
   LET g_trans[g_trans.getLength()].code = ls_temp

   LET g_trans[g_trans.getLength()+1].tag = "detail_fields"
   LET g_trans[g_trans.getLength()].code = ls_temp2
   #first_page
   #LET g_trans[g_trans.getLength()+1].tag = "first_page" #第一預設分頁
   #LET g_trans[g_trans.getLength()].code = ls_first_page

   #aoos020 特別處理
   LET g_trans[g_trans.getLength()+1].tag = "define_field_ooef_variable"
   LET g_trans[g_trans.getLength()].code = " "
   LET g_trans[g_trans.getLength()+1].tag = "variable_ooef_list"
   LET g_trans[g_trans.getLength()].code = " "
   LET g_trans[g_trans.getLength()+1].tag = "field_ooef_list"
   LET g_trans[g_trans.getLength()].code = " "

   LET g_trans[g_trans.getLength()+1].tag = "variable_ooef_list_init" 
   LET g_trans[g_trans.getLength()].code = " "
   #參考欄位
   LET g_trans[g_trans.getLength()+1].tag = "show_ref" 
   LET g_trans[g_trans.getLength()].code = " "

   
   LET li_only_once =  TRUE  
   LET lc_gzsv001 = ms_prog
   #先取分頁 再取分項 最後再取參數
   FOREACH adzp153_data_prep_cs INTO l_gzsx[li_cnt].gzsx002,l_gzsx[li_cnt].gzsx003

      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      ELSE
          SELECT  COUNT(*) INTO li_total FROM  gzsv_t  
             WHERE  gzsv001 = lc_gzsv001              #作業
             AND    gzsv002 = l_gzsx[li_cnt].gzsx002  #分頁 
             AND    gzsv003 = l_gzsx[li_cnt].gzsx003  #分項      
         IF li_total = 0 THEN
            CONTINUE FOREACH
         END IF

      END IF

      #第一次程式程式時，所預設的分頁
      IF li_only_once THEN 
         LET ls_first_page =  l_gzsx[li_cnt].gzsx002
         LET g_trans[g_trans.getLength()+1].tag = "first_page" #第一預設分頁
         LET g_trans[g_trans.getLength()].code = ls_first_page
      END IF 

      #=============先處理分頁=============
      IF l_gzsx[li_cnt].gzsx002 <> l_gzsx002_t THEN #不同分頁也就是說換頁
         LET li_item = 0
         FOR li_cnt2 = 1 TO g_trans.getLength()
             # 切換參數區塊 & 更換參數Title圖示文字
             LET li_cnt2 = 5
             LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,"\n",li_space*2 SPACES,"ON ACTION ",l_gzsx[li_cnt].gzsx002 CLIPPED,
                                                     "\n",li_space*3 SPACES,'CALL ',ms_prog,'_parameter_switch("',l_gzsx[li_cnt].gzsx002 CLIPPED,'")'
             
             LET li_cnt2 = li_cnt2 + 1
             LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,"\n",li_space*2 SPACES,"ON ACTION ",l_gzsx[li_cnt].gzsx002 CLIPPED,
                                                     "\n",li_space*3 SPACES,'CALL ',ms_prog,'_parameter_switch("',l_gzsx[li_cnt].gzsx002 CLIPPED,'")'

             #指定各參數區塊資料
             LET li_cnt2 = li_cnt2 + 1
             LET li_layer = li_layer + 1
             LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,"\n",li_space SPACES,"LET g_parameter[",li_layer USING "<<<<","].id = \"",l_gzsx[li_cnt].gzsx002 CLIPPED,"\"",
                                                     "\n",li_space SPACES,"LET g_parameter[",li_layer USING "<<<<","].name = \"aoo-702\"",
                                                     "\n",li_space SPACES,"LET g_parameter[",li_layer USING "<<<<","].comp = \"scrgr",li_layer USING"<<<<","\"",
                                                     "\n",li_space SPACES,"LET g_parameter[",li_layer USING "<<<<","].img = \"24/s_setting.png\""
            
             EXIT FOR 
         END FOR 
      END IF
      
      LET li_cnt2 = 8
      # 子參數區塊開關 隱藏/顯示
      LET li_item = li_item + 1 
      LET ls_temp = "paramsubgp",li_layer USING "<<<<","_",li_item USING "<<<<"
      LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,"\n",li_space*2 SPACES,"ON ACTION btn_",ls_temp,
                                                        "\n",li_space*3 SPACES,'CALL ',ms_prog,'_parameter_group_switch("',ls_temp,'")'
            
      
      #下去抓取個別參數
      LET li_bak = li_pos
                                                                                
      #DISPLAY  "ms_prog:",ms_prog ," l_gzsx[li_cnt].gzsx002:",l_gzsx[li_cnt].gzsx002 ,  " l_gzsx[li_cnt].gzsx003:",l_gzsx[li_cnt].gzsx003
                                                                                           #陣列位置,#tag 位置  
      CALL adzp153_data_item_prepare(ms_prog,l_gzsx[li_cnt].gzsx002,l_gzsx[li_cnt].gzsx003,li_pos,(li_cnt2+1)) RETURNING li_pos

      IF l_gzsx[li_cnt].gzsx002 <> l_gzsx002_t AND li_pos <> li_bak THEN
         LET ls_colid = g_gzsz[li_bak].gzsv002,"_",g_gzsz[li_bak].gzsv003,"_",g_gzsz[li_bak].gzsv004 USING "<<<<"
         LET li_cnt2 = 6
         LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,"\n",li_space*3 SPACES,"NEXT FIELD ",ls_colid
      END IF 
      LET l_gzsx002_t = l_gzsx[li_cnt].gzsx002
      LET li_only_once =  FALSE   
   END FOREACH

# 17/01/17 by jrg542
#   IF g_t100debug = "9" THEN
#      FOR li_cnt = 1 TO g_gzsz.getLength()
#          DISPLAY "參數編號:",g_gzsz[li_cnt].gzsz002 ," li_cnt(陣列index):",li_cnt, " gzsv002(分頁編號):", g_gzsz[li_cnt].gzsv002 , " gzsv003(分項編號):",g_gzsz[li_cnt].gzsv003 ," gzsv004(序號):" g_gzsz[li_cnt].gzsv004 " gzsz013(校驗):",g_gzsz[li_cnt].gzsz013 ," gzsz014(開窗):" ,g_gzsz[li_cnt].gzsz014," gzsv007(設定額外檢查功能):",g_gzsz[li_cnt].gzsv007,
#                  " gzsv008(設定修改後追改功能):",g_gzsz[li_cnt].gzsv008
#      END FOR  
#   END IF
# 17/01/17  
   
   #個別參數處理
   FOR li_cnt = 1 TO g_gzsz.getLength()
      LET ls_colid = ""
      IF g_gzsz[li_cnt].gzsv002 IS NOT NULL THEN
         #分頁_分項_序號
         LET ls_colid = g_gzsz[li_cnt].gzsv002,"_",g_gzsz[li_cnt].gzsv003,"_",g_gzsz[li_cnt].gzsv004 USING "<<<<"
         IF g_t100debug = "9" THEN
            DISPLAY "分頁_分項_序號:",ls_colid , "參數編號:",g_gzsz[li_cnt].gzsz002 ," li_cnt(陣列index):",li_cnt, " gzsv002(分頁編號):", g_gzsz[li_cnt].gzsv002 , " gzsv003(分項編號):",g_gzsz[li_cnt].gzsv003 ," gzsv004(序號):" ,g_gzsz[li_cnt].gzsv004 ," gzsz013(校驗):",g_gzsz[li_cnt].gzsz013 ," gzsz014(開窗):" ,g_gzsz[li_cnt].gzsz014," gzsv007(設定額外檢查功能):",g_gzsz[li_cnt].gzsv007,
                    " gzsv008(設定修改後追改功能):",g_gzsz[li_cnt].gzsv008
         END IF
         FOR li_cnt2 =  1 TO g_trans.getLength()
             #variable_list 
             LET li_cnt2 =  1
             #g_ooaa_d[2].ooaa002
             LET ls_temp = "g_",ls_table.subString(1,4),"_d[",li_cnt USING "<<<<","].",ls_table.subString(1,4),"002"
             #舊值g_ooaa_d_t[2].ooaa002
             LET ls_temp_t = "g_",ls_table.subString(1,4),"_d_t[",li_cnt USING "<<<<","].",ls_table.subString(1,4),"002"

             IF li_cnt MOD 5 = 0 THEN 
                LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,ls_temp
                IF li_cnt != g_gzsz.getLength() THEN 
                    LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,",\n",li_space*2 SPACES
                END IF 
             ELSE 
                LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,ls_temp
                IF li_cnt != g_gzsz.getLength() THEN 
                   LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,","
                END IF 
             END IF 
             
             #field_list
             LET li_cnt2 =  li_cnt2 + 1
             IF li_cnt MOD 5 = 0 THEN
                LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,ls_colid
                IF li_cnt != g_gzsz.getLength() THEN
                   LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,",\n",3 SPACES
                END IF 
             ELSE
                LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,ls_colid
                IF li_cnt != g_gzsz.getLength() THEN
                   LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,","
                END IF
             END IF

             #3
             LET li_cnt2 =  li_cnt2 + 1                                               #ON ACTION help_分頁_分項_序號
             LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,"\n",li_space*2 SPACES,"ON ACTION help_",ls_colid,
                                                     "\n",li_space*3 SPACES,'CALL ',ms_prog,'_show_field_help("',g_gzsz[li_cnt].gzsz001 CLIPPED,'","',g_gzsz[li_cnt].gzsz002 CLIPPED,'")'
             #4                                    
             LET li_cnt2 =  li_cnt2 + 1                                               #BEFORE FIELD 分頁_分項_序號
             LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,"\n",li_space*3 SPACES,"BEFORE FIELD ",ls_colid,
                                                     "\n",li_space*4 SPACES,'CALL ',ms_prog,'_show_field_help("',g_gzsz[li_cnt].gzsz001 CLIPPED,'","',g_gzsz[li_cnt].gzsz002 CLIPPED,'")'
                                                                                      #AFTER FIELD 分頁_分項_序號
             
             LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,"\n \n",li_space*3 SPACES,"AFTER FIELD ",ls_colid ,"\n" 

            #『輸入限制資料型態』設定為『整數選項 』，則『值域範圍說明(SCC)』不須設定，『值域範圍』請給予整數值範圍
            #A.有上下邊界 (含上下邊界的)，可填入 0-300 (從0到300皆為合法)
            #B.只有單邊界的，可填入 >0 或 >=0 或 <1 或 <=-1 系統會偵測符號
            #C.離散性的資料，可以用逗號分隔，如：1,8,9,20,21,99
            #(不支援混搭，只能選擇其中一種)


            #『輸入限制資料型態』設定為『範圍設定 』，則『值域範圍說明(SCC)』不須設定，『值域範圍』請給予數值範圍
            # 範圍填寫方法：有上下邊界 (含上下邊界的)，可填入 0-300 (從0到300皆為合法)
            # 只有單邊界的，可填入 >0 或 >=0 或 <1 或 <=-1 系統會偵測符號
            # 畫面會提供一個 Edit，並於 after field 設定檢查用的 library
             IF g_gzsz[li_cnt].gzsz003 = "2" OR g_gzsz[li_cnt].gzsz003 = "3"  OR g_gzsz[li_cnt].gzsz003 = "4" OR g_gzsz[li_cnt].gzsz003 = "5" THEN 
                # gzsz003 1:Y/N         gzsz009:值域範圍
                #         2:整數選項 
                #         3:範圍設定
                #         4:字元
                #         5:日期
                CASE 
                   #2:整數選項 3:範圍設定
                   WHEN g_gzsz[li_cnt].gzsz003 = "2" OR g_gzsz[li_cnt].gzsz003 = "3"
                      #判斷數字區間或( > >=  < <= )符號 組cl_ap_chk_Range() 的區塊
                      LET ls_temp2 = adzp153_chk_gzsz003(g_gzsz[li_cnt].gzsz003,g_gzsz[li_cnt].gzsz009,ls_temp,ls_colid)
                      LET g_trans[li_cnt2].code = g_trans[li_cnt2].code , li_space*3 SPACES ,ls_temp2 ,"\n" 
                      IF g_gzsz[li_cnt].gzsz003 = "2" THEN 
                         #假如是整數組判斷小數的區塊
                         LET ls_temp2 = adzp153_read_slice("ss01")
                         LET g_trans[li_cnt2].code = g_trans[li_cnt2].code , li_space*3 SPACES ,ls_temp2 ,"\n" 
                      END IF 
                      #『整數選項』OR『範圍設定』 OR『字元』(未設定SCC) 情況下，才可以設定『開窗  (查詢r.q是否存在)
                      # 若有設定校驗 (gzsz013)，則寫入 AFTER FIELD
                      # 若有設定額外檢查功能 (gzsv007) 則寫入AFTER FIELD
                      LET ls_temp2 = adzp153_chk_gzsz013_and_gzsv007(g_gzsz[li_cnt].gzsv007,g_gzsz[li_cnt].gzsz013,ls_temp,ls_temp_t,ls_colid)
                      LET g_trans[li_cnt2].code = g_trans[li_cnt2].code ,li_space*3 SPACES ,ls_temp2 ,"\n"   
                      
                    WHEN g_gzsz[li_cnt].gzsz003 = "4"
                       #『整數選項』OR『範圍設定』 OR『字元』(未設定SCC) 情況下，才可以設定『開窗  (查詢r.q是否存在)
                       # 若有設定校驗 (gzsz013)，則寫入 AFTER FIELD
                       # 若有設定額外檢查功能 (gzsv007) 則寫入AFTER FIELD

                       #15/05/25 不管有沒有scc(也就是combobox) 可以有 設定額外檢查功能 (gzsv007)
                       --LET li_chk = sadzp153_chk_gzsz016(g_gzsz[li_cnt].gzsz016) 
                       #IF NOT sadzp153_chk_gzsz016(g_gzsz[li_cnt].gzsz016) THEN
                          LET ls_temp2 = adzp153_chk_gzsz013_and_gzsv007(g_gzsz[li_cnt].gzsv007,g_gzsz[li_cnt].gzsz013,ls_temp,ls_temp_t,ls_colid)
                          LET g_trans[li_cnt2].code = g_trans[li_cnt2].code ,li_space*3 SPACES ,ls_temp2 ,"\n"
                       #END IF 
                       #15/05/25 

                       #17/02/10 apss010 特別處理 參數是S-MFG-0062 要額外加入 invisible 屬性、密碼遮罩處理加密
                       IF g_gzsz[li_cnt].gzsz002 = "S-MFG-0062" THEN 
                          #傳入新值然後加密
                          LET ls_temp2 = adzp153_encode(ls_temp,ls_temp_t) 
                          LET g_trans[li_cnt2].code = g_trans[li_cnt2].code ,li_space*3 SPACES ,ls_temp2
                       END IF 

                    WHEN g_gzsz[li_cnt].gzsz003 = "5"  
                         LET ls_temp2 = adzp153_chk_gzsv007(g_gzsz[li_cnt].gzsv007,ls_temp,ls_temp_t,ls_colid)
                         LET g_trans[li_cnt2].code = g_trans[li_cnt2].code ,ls_temp2 

                         

                END CASE
             END IF
             
             #btn_controlp
             IF NOT cl_null(g_gzsz[li_cnt].gzsz014) THEN 
                LET g_trans[26].code = g_trans[26].code,"\n",li_space*2 SPACES ,"ON ACTION controlp INFIELD ",ls_colid ,"\n",
                                    adzp153_process_open_win(g_gzsz[li_cnt].gzsz014,ls_temp,ls_colid)
               
             END IF 

             #16/03/14 設定修改後追改功能
             #有設定才有產生這段程式
             IF NOT cl_null(g_gzsz[li_cnt].gzsv008) THEN 
                LET ls_temp2 = adzp153_chk_gzsv008(g_gzsz[li_cnt].gzsv008,ls_temp,ls_colid) 
                FOR li_cnt2 = 1 TO g_trans.getLength() 
                    IF g_trans[li_cnt2].tag = "modify_after_chk" THEN 
                       LET g_trans[li_cnt2].code = g_trans[li_cnt2].code,ls_temp2
                    END IF 
                END FOR 
             END IF       
             EXIT FOR  
         END FOR 
      END IF
   END FOR

   CASE 
      
      WHEN ms_prog = "aoos010"
         FOR li_cnt2 = 1 TO g_trans.getLength()
            CALL adzp153_extra_process_aoos010(li_cnt2)
         END FOR
      #170124-00020 #1 start    
      #aoos020特殊處裡 
      #15/06/30 加入 ains010、apms010、apss010、aqcs010、asfs010、axms010、 bphs020_ph
#      WHEN ms_prog = "aoos020" OR ms_prog =  "ains010" OR ms_prog = "apms010" OR ms_prog =  "apss010" OR ms_prog =  "aqcs010" OR ms_prog =  "asfs010" OR ms_prog =  "axms010" OR ms_prog =  "bphs020_ph"
#         FOR li_cnt2 = 1 TO g_trans.getLength()
#              CALL adzp153_extra_process_aoos020(li_cnt2)
#         END FOR

      OTHERWISE
        #判斷據點級參數
        LET li_chk = FALSE  
        FOR li_cnt2 = 1 TO g_gzsv.getLength()
            IF ms_prog = g_gzsv[li_cnt2] THEN 
               LET li_chk = TRUE 
               EXIT FOR 
            END IF 
        END FOR 

        IF li_chk THEN 
           FOR li_cnt2 = 1 TO g_trans.getLength()
               CALL adzp153_extra_process_aoos020(li_cnt2)
           END FOR
        END IF   
   END CASE 
   IF g_t100debug = "9" THEN
      DISPLAY "據點級參數(1:是/0:不是):",li_chk ," prog:",ms_prog
   END IF
   #170124-00020 #1 end
END FUNCTION

#+ 先到gzsv_t 抓取程式相關 在到 gzsz_t 取參數細項
PRIVATE FUNCTION adzp153_data_item_prepare(lc_gzsv001,lc_gzsv002,lc_gzsv003,li_pos,li_index)
   DEFINE lc_gzsv001 LIKE gzsv_t.gzsv001
   DEFINE lc_gzsv002 LIKE gzsv_t.gzsv002
   DEFINE lc_gzsv003 LIKE gzsv_t.gzsv003
   DEFINE lc_gzsv005 LIKE gzsv_t.gzsv005
   DEFINE lc_gzsv006 LIKE gzsv_t.gzsv006
   DEFINE li_pos     LIKE type_t.num5
   DEFINE li_index     LIKE type_t.num5

   DECLARE adzp153_data_item_cs_pre CURSOR FOR  
      SELECT  gzsv002,gzsv003,gzsv004,gzsv005,gzsv006,gzsv007,gzsv008
        FROM  gzsv_t
        WHERE  gzsv001 = lc_gzsv001
        AND  gzsv002 = lc_gzsv002
        AND  gzsv003 = lc_gzsv003
        ORDER BY gzsv004   
   FOREACH adzp153_data_item_cs_pre INTO g_gzsz[li_pos].gzsv002,g_gzsz[li_pos].gzsv003,g_gzsz[li_pos].gzsv004,lc_gzsv005,lc_gzsv006,g_gzsz[li_pos].gzsv007,
                                         g_gzsz[li_pos].gzsv008
      CALL adzp153_data_item(lc_gzsv005,lc_gzsv006,li_pos,li_index) 
      LET li_pos = li_pos + 1
   END FOREACH
   CALL g_gzsz.deleteElement(li_pos)
   CLOSE adzp153_data_item_cs_pre 
   RETURN g_gzsz.getLength()+1

END FUNCTION 
 
#+ 抓取細項參數資料
PRIVATE FUNCTION adzp153_data_item(lc_gzsz001,lc_gzsz002,li_pos,li_index)
   DEFINE li_pos     LIKE type_t.num5
   DEFINE lc_gzsz006 LIKE gzsz_t.gzsz006  #分頁編號
   DEFINE lc_gzsz007 LIKE gzsz_t.gzsz007  #分項編號
   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE li_index   LIKE type_t.num5     #第9個index 給scc_combo 使用
   DEFINE ls_name    STRING 
   DEFINE lc_gzsz001 LIKE gzsz_t.gzsz001
   DEFINE lc_gzsz002 LIKE gzsz_t.gzsz002
   
   #gzsv002 LIKE gzsz_t.gzsz006,   #分頁編號
   #gzav003 LIKE gzsz_t.gzsz007,   #分項編號
   #pos     LIKE type_t.num5,      #本項序號
   #gzsz002 LIKE gzsz_t.gzsz002,   #參數編號
   #gzsz003 LIKE gzsz_t.gzsz003,   #輸入型態
   #gzsz008 LIKE gzsz_t.gzsz008,   #預設值
   #gzsz009 LIKE gzsz_t.gzsz009,   #值域範圍
   #gzsz013 LIKE gzsz_t.gzsz013,   #校驗
   #gzsz014 LIKE gzsz_t.gzsz014,   #開窗
   #gzsz016 LIKE gzsz_t.gzsz016    #值域範圍說明

   LET ls_sql = "SELECT gzsz002,gzsz003,gzsz008,gzsz009,gzsz013,gzsz014,gzsz016 ",
                " FROM gzsz_t ",
                " WHERE gzsz001 = '",lc_gzsz001 CLIPPED ,"' ",  #表格編號
                " AND gzsz002 = '",lc_gzsz002 CLIPPED,"' ",     #參數編號
                " AND gzszstus = 'Y' ",
                " ORDER BY gzsz005 "             

   DECLARE adzp153_data_item_cs CURSOR FROM ls_sql
   LET li_cnt = 1

   FOREACH adzp153_data_item_cs INTO g_gzsz[li_pos].gzsz002,g_gzsz[li_pos].gzsz003,g_gzsz[li_pos].gzsz008,
                                     g_gzsz[li_pos].gzsz009,g_gzsz[li_pos].gzsz013,g_gzsz[li_pos].gzsz014,g_gzsz[li_pos].gzsz016
      LET g_gzsz[li_pos].gzsz001 = lc_gzsz001  
      #檢核gzsz016是否有存在scc 存在就組 cl_set_combo_scc
      IF sadzp153_chk_gzsz016(g_gzsz[li_pos].gzsz016) THEN
         LET ls_name = g_gzsz[li_pos].gzsv002 CLIPPED,
                       "_",g_gzsz[li_pos].gzsv003 CLIPPED,"_",g_gzsz[li_pos].gzsv004 USING "<<<<"
         #xxx_init() 區塊放入CALL cl_set_combo_scc 
         LET g_trans[li_index].code = g_trans[li_index].code ,"CALL cl_set_combo_scc('",DOWNSHIFT(ls_name),"','",g_gzsz[li_pos].gzsz016 USING "<<<<<<" ,"') \n",li_space SPACE 
      END IF 
  
   END FOREACH
   CLOSE adzp153_data_item_cs
END FUNCTION

#+ 程式讀取/程式寫出(一進一出) 
PRIVATE FUNCTION adzp153_read_and_replace()
 
   DEFINE lchannel_read         base.Channel
   DEFINE lchannel_write        base.Channel
   DEFINE ls_readline           STRING
   DEFINE ls_text               STRING
   DEFINE ls_code_filename      STRING
   DEFINE ls_sample_filename    STRING 
   
   LET lchannel_read = base.Channel.create()
   LET lchannel_write = base.Channel.create()
 
   CALL lchannel_read.setDelimiter("")
   CALL lchannel_write.setDelimiter("")

   #定義寫入檔案  $ERP/Module/4gl/xxxxx.4gl
   LET ls_code_filename = os.Path.join(os.Path.join(FGL_GETENV("ERP"),ms_module),"4gl")
   LET ls_code_filename = os.Path.join(ls_code_filename,ms_prog||".4gl")

   #定義要讀取的 template 檔案
   #先讀取T100TEMPLATEPATH, 若無則採用$ERP/mdl
   LET ls_sample_filename = FGL_GETENV("T100TEMPLATEPATH") #os.Path.join(FGL_GETENV("ERP"),"mdl")
   IF cl_null(ls_sample_filename) THEN
      LET ls_sample_filename = FGL_GETENV("ERP")
      LET ls_sample_filename = os.Path.join(ls_sample_filename,"mdl")
   END IF

   LET ls_sample_filename = os.Path.join(ls_sample_filename,"code_s01.template")
   DISPLAY "azdp153:產生器" 

   #檢查來源
   IF NOT os.Path.exists(ls_sample_filename) THEN
      DISPLAY "Error:來源檔案:",ls_sample_filename.trim()," 不存在!"
      EXIT PROGRAM
   ELSE
      DISPLAY "來源檔:",ls_sample_filename
      CALL lchannel_read.openFile( ls_sample_filename CLIPPED, "r" )
   END IF

   #先行移除4gl
   IF os.Path.delete(ls_code_filename) THEN
      DISPLAY "刪除舊檔案:",ls_code_filename
   END IF

   #判斷是否砍除成功
   IF NOT os.Path.exists(ls_code_filename) THEN
      DISPLAY "舊檔案刪除成功:",ls_code_filename
   ELSE
      DISPLAY "Error:舊檔案刪除失敗:",ls_code_filename
      EXIT PROGRAM
   END IF

   DISPLAY "目的檔:",ls_code_filename
   CALL lchannel_write.openFile( ls_code_filename CLIPPED, "w" )
   #讀取及轉換
   
   WHILE TRUE
      LET ls_text = ""
      LET ls_readline = lchannel_read.readLine()
      IF lchannel_read.isEof() THEN
         EXIT WHILE
      END IF

     #行代換/ 對 ${} 置換
      IF ls_readline.getIndexOf("${",1) AND
         (ls_readline.getIndexOf("${",1) < ls_readline.getIndexOf("}",1)) THEN 
         LET ls_text = adzp153_line_replace(ls_readline)
      END IF

      #一般未進行任何處理段落產出
      IF ls_text IS NULL THEN
         LET ls_text = ls_readline
      END IF
      
      CALL lchannel_write.write(ls_text)
   END WHILE
   
   CALL lchannel_read.close()
   CALL lchannel_write.close()
   
   DISPLAY ls_code_filename,"產生成功!"
   
   #對產生器寫出的檔案權限在UNIX下均全部打開
   IF os.Path.separator() = "/" THEN
      IF os.Path.chrwx(ls_code_filename,511) THEN
      END IF
   END IF
   RETURN ls_code_filename
END FUNCTION
 
#+ 從db內把資料讀出來
PRIVATE FUNCTION adzp153_line_replace(ls_readline)
   DEFINE ls_readline  STRING 
   DEFINE ls_text      STRING
   DEFINE li_pos,li_end,li_cnt LIKE type_t.num5
   DEFINE ls_tag  STRING

   LET li_pos = ls_readline.getIndexOf("${",1)

   #取出待轉換的tag
   IF li_pos > 0 THEN
      LET li_end = ls_readline.getIndexOf("}",li_pos+2)
      LET ls_tag = ls_readline.subString(li_pos+2,li_end-1)
      
      FOR li_cnt = 1 TO g_trans.getLength()
         IF g_trans[li_cnt].tag = ls_tag THEN
            IF li_pos = 1 THEN
               LET ls_readline = ls_readline.subString(1,li_pos-1),g_trans[li_cnt].code,ls_readline.subString(li_end,ls_readline.getLength()-1)
               LET ls_text =  ls_readline.subString(1,ls_readline.getLength()-1)           
            ELSE
               LET ls_text = ls_readline.subString(1,li_pos-1),
                             g_trans[li_cnt].code,
                             ls_readline.subString(li_end+1,ls_readline.getLength())
            END IF
         END IF
      END FOR
   END IF

   #遞迴處理同行其他組
   IF ls_text.getIndexOf("${",1) THEN
      LET ls_text = adzp153_line_replace(ls_text)
   END IF
   IF ls_text IS NULL THEN
      LET ls_text = ls_readline
   END IF

   RETURN ls_text
END FUNCTION

#+ 取得tabl_id 
PRIVATE FUNCTION adzp153_get_table_info()
   DEFINE lc_gzsz001 LIKE gzsz_t.gzsz001 
   DEFINE la_gzsz    DYNAMIC ARRAY OF RECORD
             gzsz001 LIKE gzsz_t.gzsz001
                     END RECORD
   DEFINE ls_sql     STRING 
   DEFINE li_cnt     LIKE type_t.num5

   CALL la_gzsz.clear()
   LET li_cnt = 1
   LET ls_sql = " SELECT DISTINCT gzsv005  ", 
                  " FROM gzsv_t ",
                 " WHERE gzsv001 = '",ms_prog.trim(),"'"
   DECLARE adzp153_table_info_pre CURSOR FROM ls_sql
   FOREACH adzp153_table_info_pre INTO la_gzsz[li_cnt].gzsz001
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      IF li_cnt = 1 THEN
         LET lc_gzsz001 = la_gzsz[li_cnt].gzsz001
      END IF
      LET li_cnt = li_cnt + 1
   END FOREACH
   CALL la_gzsz.deleteElement(li_cnt)
   
   FREE adzp153_table_info_pre 
   RETURN la_gzsz,lc_gzsz001
END FUNCTION 

#+ 取得 fields 
PRIVATE FUNCTION adzp153_get_field_info(pc_table)
   DEFINE lc_dzeb002 LIKE dzeb_t.dzeb002
   DEFINE lc_dzeb004 LIKE dzeb_t.dzeb004
   DEFINE lc_dzeb005 LIKE dzeb_t.dzeb005
   DEFINE lc_dzeb006 LIKE dzeb_t.dzeb006
   DEFINE pc_table   LIKE dzeb_t.dzeb001  
   DEFINE ls_field   STRING 
   DEFINE ls_temp    STRING
   DEFINE ls_temp_2  STRING 
   DEFINE ls_define  STRING 
   DEFINE ls_define_desc STRING 
   DEFINE ls_sql     STRING 
   DEFINE li_ent     LIKE type_t.num5
   DEFINE li_site    LIKE type_t.num5
   DEFINE ls_select_fields STRING  

   LET ls_sql = " SELECT dzeb002,dzeb004,dzeb005,dzeb006 " , 
                  " FROM dzeb_t ", 
                 " WHERE dzeb001 = ? ORDER BY dzeb021 "
   PREPARE adzp153_field_info_pre FROM ls_sql
   DECLARE adzp153_field_info_curs CURSOR FROM ls_sql 

   LET li_ent = FALSE 
   LET li_site = FALSE 
   OPEN adzp153_field_info_curs USING pc_table
    FOREACH adzp153_field_info_curs INTO lc_dzeb002,lc_dzeb004,lc_dzeb005,lc_dzeb006
       LET ls_define = ""
       LET ls_define_desc = ""
       LET ls_select_fields = ""
       LET ls_field = lc_dzeb002

#display ls_field
         IF g_t100debug = "9" THEN
            DISPLAY "ls_field:",ls_field  ," lc_dzeb004:",lc_dzeb004 ," lc_dzeb005:",lc_dzeb005 ," lc_dzeb006:",lc_dzeb006
         END IF
       CASE 
          #判別site field
          WHEN ls_field.getIndexOf("site",1) 
               LET li_site = TRUE 
               LET g_trans[g_trans.getLength()+1].tag = "detail_append_site_wc"  
               LET g_trans[g_trans.getLength()].code = ls_field ,"=g_site "," AND "

               LET g_trans[g_trans.getLength()+1].tag = "detail_var_site_append"
               LET g_trans[g_trans.getLength()].code = ",\" AND \",ls_tab,\"site = '\",g_site CLIPPED,\"'\"" 
#display "aw:--->",g_trans[g_trans.getLength()].code

               LET g_trans[g_trans.getLength()+1].tag = "detail_column_site"
               LET g_trans[g_trans.getLength()].code = ",\",ls_tab,\"site" 

               LET g_trans[g_trans.getLength()+1].tag = "detail_value_site"
               LET g_trans[g_trans.getLength()].code = ",?"

               LET g_trans[g_trans.getLength()+1].tag = "detail_site"
               LET g_trans[g_trans.getLength()].code = ",g_site"
               
               CONTINUE FOREACH 

          #判別ent field
          WHEN ls_field.getIndexOf("ent",1) 
               LET li_ent = TRUE 
               LET g_trans[g_trans.getLength()+1].tag = "detail_append_ent_wc"  
               LET g_trans[g_trans.getLength()].code = ls_field ,"=g_enterprise "," AND "

               LET g_trans[g_trans.getLength()+1].tag = "detail_var_ent_append"
               LET g_trans[g_trans.getLength()].code = ",\" AND \",ls_tab,\"ent = \",g_enterprise" 

               LET g_trans[g_trans.getLength()+1].tag = "detail_column_ent_ins"
               LET g_trans[g_trans.getLength()].code = ",\",ls_tab,\"ent" 

               LET g_trans[g_trans.getLength()+1].tag = "detail_value_ent"
               LET g_trans[g_trans.getLength()].code = ",?" 

               LET g_trans[g_trans.getLength()+1].tag = "detail_enterprise"
               LET g_trans[g_trans.getLength()].code = ",g_enterprise" 

               CONTINUE FOREACH 
               
          WHEN ls_field.getIndexOf("modid",1) OR ls_field.getIndexOf("crtid",1)  OR ls_field.getIndexOf("ownid",1) 
               OR ls_field.getIndexOf("crtdp",1)  
               
               IF ls_field.getIndexOf("modid",1) THEN 
                  LET g_trans[g_trans.getLength()+1].tag = "field_modid"  
                  LET g_trans[g_trans.getLength()].code = ls_field
               END IF 
               
               LET ls_define = li_space SPACES ,ls_field ," LIKE ",pc_table,".",ls_field ,",\n"
               LET ls_define_desc = li_space SPACES ,ls_field ,"_desc"," LIKE type_t.chr80,\n" 
 
               LET ls_select_fields = ls_field,",'',"
          WHEN ls_field.getIndexOf("moddt",1)  OR ls_field.getIndexOf("crtdt",1)   

               IF ls_field.getIndexOf("moddt",1) THEN 
                  LET g_trans[g_trans.getLength()+1].tag = "field_moddt"  
                  LET g_trans[g_trans.getLength()].code = ls_field
               END IF 
               LET ls_define = li_space SPACES,ls_field ," DATETIME YEAR TO SECOND,\n"
               LET ls_select_fields = ls_field ,","
          #WHEN lc_dzeb005 = "Y" AND lc_dzeb006 = "C101"  #160511-00003 #1 mark
          WHEN lc_dzeb006 = "C101" 
               LET g_trans[g_trans.getLength()+1].tag = "field_fk"  
               LET g_trans[g_trans.getLength()].code = ls_field
               LET ls_define = li_space SPACES,ls_field," LIKE ",pc_table,".",ls_field ,",\n"
               LET ls_select_fields = ls_field,","
          WHEN lc_dzeb004 = "Y" AND lc_dzeb005 = "Y"  
               LET g_trans[g_trans.getLength()+1].tag = "field_pk"  
               LET g_trans[g_trans.getLength()].code = ls_field
               LET ls_define = li_space SPACES ,ls_field ," LIKE ",pc_table,".",ls_field ,",\n"
               LET ls_define_desc = li_space SPACES  ,ls_field ,"_desc"," LIKE type_t.chr80,\n"   
               LET ls_select_fields = ls_field,",''," 
       END CASE  
       LET ls_temp = ls_temp,ls_define,ls_define_desc
       LET ls_temp_2 = ls_temp_2,ls_select_fields
    END FOREACH 

    IF NOT li_ent THEN
       LET g_trans[g_trans.getLength()+1].tag = "detail_append_ent_wc"
       LET g_trans[g_trans.getLength()].code = " "

       LET g_trans[g_trans.getLength()+1].tag = "detail_var_ent_append"
       LET g_trans[g_trans.getLength()].code = " "
       
       LET g_trans[g_trans.getLength()+1].tag = "detail_column_ent_ins"
       LET g_trans[g_trans.getLength()].code = " "

       LET g_trans[g_trans.getLength()+1].tag = "detail_value_ent"
       LET g_trans[g_trans.getLength()].code = " "

       LET g_trans[g_trans.getLength()+1].tag = "detail_enterprise"
       LET g_trans[g_trans.getLength()].code = " "
    END IF
    IF NOT li_site THEN 
       LET g_trans[g_trans.getLength()+1].tag = "detail_append_site_wc"
       LET g_trans[g_trans.getLength()].code = " "

       LET g_trans[g_trans.getLength()+1].tag = "detail_var_site_append"
       LET g_trans[g_trans.getLength()].code = " "

       LET g_trans[g_trans.getLength()+1].tag = "detail_column_site"
       LET g_trans[g_trans.getLength()].code = " "

       LET g_trans[g_trans.getLength()+1].tag = "detail_value_site"
       LET g_trans[g_trans.getLength()].code = " "

       LET g_trans[g_trans.getLength()+1].tag = "detail_site"
       LET g_trans[g_trans.getLength()].code = " "
    END IF 

    LET ls_temp = ls_temp.subString(1,ls_temp.getLength()-1)
    LET ls_temp_2 = ls_temp_2.subString(1,ls_temp_2.getLength()-1)
    
    CLOSE adzp153_field_info_curs
    FREE adzp153_field_info_pre
    IF g_t100debug = "9" THEN
       DISPLAY "目前定義欄位:",ls_temp
       DISPLAY "目前SELECT欄位:",ls_temp_2
    END IF
    RETURN ls_temp,ls_temp_2
END FUNCTION 

#+檢核模組
PRIVATE FUNCTION azzp153_chk_module(ps_module)
   DEFINE ps_module LIKE gzzo_t.gzzo001 
   DEFINE li_cnt LIKE type_t.num5

   SELECT count(*) INTO li_cnt FROM  gzzo_t WHERE gzzo001 = ps_module
   IF li_cnt > 0 THEN
      RETURN   FALSE 
   END IF 
   RETURN TRUE
END FUNCTION

#+ 檢核程式編號
PRIVATE FUNCTION adzp153_chk_prog(ps_prog)
   DEFINE ps_prog LIKE gzza_t.gzza001 
   DEFINE li_cnt LIKE type_t.num5

   SELECT count(*) INTO li_cnt FROM  gzza_t WHERE gzza001 = ps_prog

   IF li_cnt > 0 THEN
      RETURN   FALSE 
   END IF 
   RETURN TRUE
END FUNCTION

 
#+判斷數字區間或( > >=  < <= )符號 組cl_ap_chk_Range() 的區塊
PUBLIC FUNCTION adzp153_chk_gzsz003(ps_gzsz003,ps_gzsz009,ps_var,ps_field)
   DEFINE ps_gzsz003 STRING 
   DEFINE ps_gzsz009 STRING
   DEFINE li_index   LIKE type_t.num5
   DEFINE ps_var     STRING 
   DEFINE pi_cnt     LIKE type_t.num5
   DEFINE ps_field   STRING    #畫面欄位
   DEFINE ls_return  STRING 

   IF g_t100debug = "9" THEN
       DISPLAY "輸入型態 gzsz003:",ps_gzsz003  ," 值域範圍 gzsz009:",ps_gzsz009 ," ps_var:",ps_var," ps_field:",ps_field ," pi_cnt:",pi_cnt
   END IF
   
   LET ps_gzsz009 = ps_gzsz009.trim()
   #整數或範圍設定
   IF ps_gzsz003 = "2" OR ps_gzsz003 = "3" THEN 
      #確認第1個位置是否數字
      IF cl_chk_num(ps_gzsz009.subString(1,1),"N") THEN 
         #數字
         #組數字字串 >= 且 <= 數字區間
         LET li_index = ps_gzsz009.getIndexOf("-",1)
         IF li_index THEN 
                                                     #欄位值,值域
            LET ls_return = adzp153_set_template_chk_Range_tag(ps_var,ps_gzsz009,li_index,1,"azz-00087",ps_field)
         ELSE 
            CASE
               # 整數選項:2  可以有離散性的資料  ex:1,2,3
               WHEN ps_gzsz003 = "2" AND ps_gzsz009.getIndexOf(",",1) 
                    LET ls_return = adzp153_set_template_discrete_data_tag(ps_gzsz009,ps_var,ps_field)
               OTHERWISE 
                   LET ls_return = ""
            END CASE 
         END IF 
      ELSE  
    
         #不是數字 > >= < <=
         CASE
            WHEN ps_gzsz009.getIndexOf(">",1) OR ps_gzsz009.getIndexOf("<",1)
                 CASE 
                    WHEN ps_gzsz009.getIndexOf(">",1)
                         LET li_index = ps_gzsz009.getIndexOf(">",1)
                         IF ps_gzsz009.getIndexOf("=",li_index+1) THEN
                            LET ls_return = adzp153_set_template_chk_Range_tag(ps_var,ps_gzsz009,li_index,2,"azz-00079",ps_field)
                            EXIT CASE  
                         END IF
                         
                         LET ls_return = adzp153_set_template_chk_Range_tag(ps_var,ps_gzsz009,li_index,3,"azz-00079",ps_field) 
                    WHEN ps_gzsz009.getIndexOf("<",1)
                         LET li_index = ps_gzsz009.getIndexOf("<",1)
                         IF ps_gzsz009.getIndexOf("=",li_index+1) THEN
                            LET ls_return = adzp153_set_template_chk_Range_tag(ps_var,ps_gzsz009,li_index,4,"azz-00079",ps_field)  
                            EXIT CASE  
                         END IF
                          
                         LET ls_return = adzp153_set_template_chk_Range_tag(ps_var,ps_gzsz009,li_index,5,"azz-00079",ps_field)  
                 END CASE

              OTHERWISE                  
                 #其他
                 LET ls_return = adzp153_set_template_chk_Range_tag(ps_var,ps_gzsz009,li_index,6,"azz-00079",ps_field)  
         END CASE  
      END IF  
   END IF 
   RETURN ls_return 
END FUNCTION

#+ 生成object元件 #子樣板
PRIVATE FUNCTION adzp153_read_slice(ps_slice)
   DEFINE ps_slice        STRING
   DEFINE ls_return       STRING 
   DEFINE lchannel_read   base.Channel
   DEFINE ls_slice        STRING
   DEFINE ls_read         STRING
   DEFINE ls_text         STRING
   DEFINE ls_mdlpath      STRING 

   #定義要讀取的 template 檔案
   #先讀取T100TEMPLATEPATH, 若無則採用$ERP/mdl
   LET ls_mdlpath = FGL_GETENV("T100TEMPLATEPATH") #os.Path.join(FGL_GETENV("ERP"),"mdl")
   IF cl_null(ls_mdlpath) THEN
      LET ls_mdlpath = FGL_GETENV("ERP")
      LET ls_mdlpath = os.Path.join(ls_mdlpath,"mdl")
   END IF
   #定義取用樣板檔案
   #LET ls_slice = "slice/code_",ps_slice,".template"
   LET ls_slice = os.Path.join("slice","code_"||ps_slice||".template") 
   LET ls_slice = os.Path.join(ls_mdlpath,ls_slice)

   #開啟樣板檔
   LET lchannel_read = base.Channel.create()
   CALL lchannel_read.setDelimiter("")

   CALL lchannel_read.openFile( ls_slice CLIPPED, "r" )
   
   WHILE NOT lchannel_read.isEof()
   
      LET ls_text = ""
      #LET ls_read = lchannel_read.readLine()
      
      CASE 
         WHEN ps_slice = "ss03"
            CALL adzp153_code_fragment(lchannel_read) RETURNING ls_read,lchannel_read

         OTHERWISE 
            LET ls_read = lchannel_read.readLine()
         #WHEN ls_read.getIndexOf("#rtns - Start -",1)
         #CALL adzp150_make_rtns(lchannel_read) RETURNING ls_read,lchannel_read
         
      END CASE
      #行代換/ 對 ${} 置換
      IF ls_read.getIndexOf("${",1) AND 
         ( ls_read.getIndexOf("${",1) < ls_read.getIndexOf("}",1) ) THEN
         LET ls_text = adzp153_line_replace(ls_read)
      ELSE
         LET ls_text = ls_read
      END IF
      
      LET ls_return = ls_return, ls_text, '\n'
      
   END WHILE  
   
   CALL lchannel_read.close()

   RETURN ls_return

END FUNCTION 

#+ 設定子樣板cl_ap_chk_Range tag 
PRIVATE FUNCTION adzp153_set_template_chk_Range_tag(ps_var,ps_gzsz009,pi_index,pi_type,ps_err_code,ps_field)
   DEFINE ps_gzsz009  STRING
   DEFINE ps_var      STRING
   DEFINE pi_index    LIKE type_t.num5
   DEFINE pi_type     LIKE type_t.num5
   DEFINE ps_err_code STRING  
   DEFINE ps_field    STRING
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_return   STRING

   # "mdl_var"              #12  欄位值  
   # "mdl_min"              #13  最小值
   # "mdl_mintype"          #14  >或>=     
   # "mdl_max"              #15  最大值
   # "mdl_maxtype"          #16  <或<=
   # "mdl_error"            #17  錯誤碼
   # "mdl_ow"               #18  開窗
   # "mdl_field"            #19  畫面欄位 

   #從12開始
   LET li_cnt = 12 
   #mdl_var
   LET g_trans[li_cnt].code = ps_var
   LET li_cnt = li_cnt + 1 

   CASE 
      WHEN pi_type = 1 #>= <= 
            #mdl_min 最小值
            LET g_trans[li_cnt].code = ps_gzsz009.subString(1,pi_index-1)
            LET li_cnt = li_cnt + 1

            #mdl_mintype >=
            #1/0 等於/不等於  
            LET g_trans[li_cnt].code = "1"
            LET li_cnt = li_cnt + 1

            #mdl_max 最大值
            LET g_trans[li_cnt].code = ps_gzsz009.subString(pi_index+1,ps_gzsz009.getLength())
            LET li_cnt = li_cnt + 1

            #mdl_maxtype <=
            LET g_trans[li_cnt].code = "1"
            LET li_cnt = li_cnt + 1

            #mdl_error 錯誤碼
            LET g_trans[li_cnt].code = ps_err_code
            
      WHEN pi_type = 2 #>=
            #mdl_min
            LET g_trans[li_cnt].code = ps_gzsz009.subString(pi_index+2,ps_gzsz009.getLength())    
            LET li_cnt = li_cnt + 1   
            #mdl_mintype
            LET g_trans[li_cnt].code = "1"     
            LET li_cnt = li_cnt + 1 
            #mdl_max
            LET g_trans[li_cnt].code = ""
            LET li_cnt = li_cnt + 1 
            #mdl_maxtype
            LET g_trans[li_cnt].code = ""  
            LET li_cnt = li_cnt + 1 
            #mdl_error 
            LET g_trans[li_cnt].code = ps_err_code 

      WHEN pi_type = 3 #>
             #mdl_min
             LET g_trans[li_cnt].code = ps_gzsz009.subString(pi_index+1,ps_gzsz009.getLength())  
             LET li_cnt = li_cnt + 1   
             #mdl_mintype
             LET g_trans[li_cnt].code = "0"      
             LET li_cnt = li_cnt + 1 
             #mdl_max
             LET g_trans[li_cnt].code = ""
             LET li_cnt = li_cnt + 1 
             #mdl_maxtype
             LET g_trans[li_cnt].code = ""  
             LET li_cnt = li_cnt + 1 
             #mdl_error 
             LET g_trans[li_cnt].code = ps_err_code            
      WHEN pi_type = 4 #<=
             #mdl_min
             LET g_trans[li_cnt].code = ""     
             LET li_cnt = li_cnt + 1   
             #mdl_mintype
             LET g_trans[li_cnt].code = "0"     
             LET li_cnt = li_cnt + 1 
             #mdl_max
             LET g_trans[li_cnt].code = ps_gzsz009.subString(pi_index+2,ps_gzsz009.getLength())
             LET li_cnt = li_cnt + 1 
             #mdl_maxtype
             LET g_trans[li_cnt].code = "1"  
             LET li_cnt = li_cnt + 1 
             #mdl_error 
             LET g_trans[li_cnt].code = ps_err_code 
      WHEN pi_type = 5 #<
             #mdl_min
             LET g_trans[li_cnt].code = ""     
             LET li_cnt = li_cnt + 1   
             #mdl_mintype
             LET g_trans[li_cnt].code = "0"     
             LET li_cnt = li_cnt + 1 
             #mdl_max
             LET g_trans[li_cnt].code = ps_gzsz009.subString(pi_index+1,ps_gzsz009.getLength())
             LET li_cnt = li_cnt + 1 
             #mdl_maxtype
             LET g_trans[li_cnt].code = "1"  
             LET li_cnt = li_cnt + 1 
             #mdl_error 
             LET g_trans[li_cnt].code = ps_err_code 
      OTHERWISE 
             #沒有設定範圍設定
             #mdl_min
             LET g_trans[li_cnt].code = ""     
             LET li_cnt = li_cnt + 1   
             #mdl_mintype
             LET g_trans[li_cnt].code = "0"     
             LET li_cnt = li_cnt + 1 
             #mdl_max
             LET g_trans[li_cnt].code = ps_gzsz009.subString(1,ps_gzsz009.getLength())
             LET li_cnt = li_cnt + 1 
             #mdl_maxtype
             LET g_trans[li_cnt].code = "0"  
             LET li_cnt = li_cnt + 1 
             #mdl_error 
             LET g_trans[li_cnt].code = ps_err_code
              
   END CASE  
   LET li_cnt = li_cnt + 1 
   #mdl_ow
   LET g_trans[li_cnt].code = "1"
   LET li_cnt = li_cnt + 1 
   #mdl_field  
   LET g_trans[li_cnt].code = ps_field
   #呼叫子樣板組cl_ap_chk_Range
   RETURN adzp153_read_slice("a15") #
END FUNCTION 

#+  設定子樣板cl_chk_discrete_data tag 
PRIVATE FUNCTION adzp153_set_template_discrete_data_tag(ps_gzsz009,ps_var,ps_field)
   DEFINE ps_field   STRING 
   DEFINE ps_var     STRING 
   DEFINE ls_return  STRING 
   DEFINE ps_gzsz009 STRING
   
   LET g_trans[12].code = ps_var 
   LET g_trans[g_trans.getLength()+1].tag = "mdl_var_list" 
   LET g_trans[g_trans.getLength()].code = ps_gzsz009
   LET g_trans[19].code = ps_field 
   #cl_chk_discrete_data 
   RETURN  adzp153_read_slice("ss02")
END FUNCTION 

PRIVATE FUNCTION adzp153_chk_gzsz013_and_gzsv007(ps_gzsv007,ps_gzsz013,ps_temp,ps_temp2,ps_colid)
   DEFINE ps_gzsv007  STRING 
   DEFINE ps_gzsz013  STRING
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ps_temp     STRING 
   DEFINE ps_temp2    STRING 
   DEFINE ps_colid    STRING
   DEFINE ls_str      STRING 

   #var                #20
   #var_t              #21 
   #mdl                #22      
   #mdl_chkid          #23     
   #extra_chk          #24      
   #ps_field           #25    

      #從20開始
   LET li_cnt = 20
   #var #新值
   LET g_trans[li_cnt].code = ps_temp
   
   LET li_cnt = li_cnt +  1
   #var_t #舊值 
   LET g_trans[li_cnt].code = ps_temp2

   LET li_cnt = li_cnt + 1
   #mdl
   LET g_trans[li_cnt].code = 1

   LET li_cnt = li_cnt + 1
   #mdl_chkid
   LET g_trans[li_cnt].code = ps_gzsz013

   LET li_cnt = li_cnt + 1
   #extra_chk 設定額外檢查功能
   IF cl_null(ps_gzsv007) THEN 
      LET g_trans[li_cnt].code = ps_gzsv007 
   ELSE 
      #設定額外檢查功能
      CALL adzp153_extra_gzsv007(li_cnt,ps_gzsv007,ps_temp,ps_temp2)
   END IF 

   LET li_cnt = li_cnt + 1
   #ps_field
   LET g_trans[li_cnt].code = ps_colid
   
   #校驗 #額外檢查
   #呼叫子樣板組 cl_chk_exist()檢查及額外檢查 存在
   CASE
      WHEN cl_null(ps_gzsz013) AND cl_null(ps_gzsv007)
           RETURN ""
      WHEN NOT cl_null(ps_gzsz013) AND NOT cl_null(ps_gzsv007)
           LET gi_chk1 = TRUE  
           LET gi_chk2 = TRUE
           RETURN adzp153_read_slice("ss03")
      WHEN cl_null(ps_gzsz013) AND NOT cl_null(ps_gzsv007)
           LET gi_chk1 = FALSE 
           LET gi_chk2 = TRUE   
           RETURN adzp153_read_slice("ss03")
      WHEN NOT cl_null(ps_gzsz013) AND cl_null(ps_gzsv007)
           LET gi_chk1 = TRUE 
           LET gi_chk2 = FALSE 
           RETURN adzp153_read_slice("ss03")
   END CASE 
 
END FUNCTION 

#+aoos020特殊處裡
#+15/06/30 加入 ains010、apms010、apss010、aqcs010、asfs010、axms010
PRIVATE FUNCTION adzp153_extra_process_aoos020(pi_cnt)
   DEFINE pi_cnt LIKE type_t.num5

    #4gl define跟畫面有關的全域變數
          IF g_trans[pi_cnt].tag = "define_field_ooef_variable" THEN 
             LET g_trans[pi_cnt].code = " DEFINE g_ooef001 LIKE type_t.chr10 " ,
                                         "\n",li_space*3 SPACES ,
                                         " DEFINE ooef001_desc LIKE type_t.chr80 ", 
                                         "\n",li_space*3 SPACES 
                                         #,
                                         #" DEFINE g_ref_fields  DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列 ",
                                         #"\n",li_space*3 SPACES ,
                                         #" DEFINE g_rtn_fields  DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列 "
          END IF

          IF g_trans[pi_cnt].tag = "variable_ooef_list" THEN 
             LET g_trans[pi_cnt].code = ",g_ooef001"
          END IF 

          IF g_trans[pi_cnt].tag = "field_ooef_list" THEN 
            LET g_trans[pi_cnt].code = ",ooef001"
          END IF 

          IF g_trans[pi_cnt].tag = "variable_ooef_list_init" THEN 
            LET g_trans[pi_cnt].code = "LET g_ooef001 = g_site "
          END IF
          #參考欄位
          IF g_trans[pi_cnt].tag = "show_ref" THEN 
            LET g_trans[pi_cnt].code = " INITIALIZE g_ref_fields TO NULL " , 
                                        "\n",li_space*3 SPACES ," LET g_ref_fields[1] = g_ooef001 " , 
                                        "\n",li_space*3 SPACES ,
                                        " CALL ap_ref_array2(g_ref_fields,", "\" SELECT ooefl003 FROM ooefl_t WHERE ooeflent='","\"||g_enterprise||\"'" ,
                                        " AND ooefl001=? AND ooefl002='","\"||g_dlang||\"'\"" ,",\"\") RETURNING g_rtn_fields ",
                                        "\n",li_space*3 SPACES ," LET ooef001_desc = '', g_rtn_fields[1] , '' ",
                                        "\n",li_space*3 SPACES ," DISPLAY BY NAME ooef001_desc "
          END IF

          IF g_trans[pi_cnt].tag = "btn_controlp" THEN 
             #DISPLAY "pi_cnt:",pi_cnt
             LET g_trans[pi_cnt].code = g_trans[pi_cnt].code,"\n",li_space*2 SPACES ,"ON ACTION controlp INFIELD ooef001 "
                                                             ,"\n",li_space*3 SPACES,"CALL cl_site_select()" 
                                                             ,"\n",li_space*3 SPACES,"LET g_ooef001 = g_site"
                                                             ,"\n",li_space*3 SPACES,"DISPLAY g_ooef001 TO ooef001"
                                                             ,"\n",li_space*3 SPACES,"CALL ",ms_prog,"_fill_data()"
                                                             ,"\n",li_space*3 SPACES,"CALL cl_ask_confirm3(\"adz-00541\",\"\") " 
                                                             ,"\n",li_space*3 SPACES,"INITIALIZE g_ref_fields TO NULL "
                                                             ,"\n",li_space*3 SPACES ,"LET g_ref_fields[1] = g_ooef001 " 
                                                             ," CALL ap_ref_array2(g_ref_fields,", "\" SELECT ooefl003 FROM ooefl_t WHERE ooeflent='","\"||g_enterprise||\"'" 
                                                             ," AND ooefl001=? AND ooefl002='","\"||g_dlang||\"'\"" ,",\"\") RETURNING g_rtn_fields "
                                                             ,"\n",li_space*3 SPACES ,"LET ooef001_desc = '', g_rtn_fields[1] , '' "
                                                             ,"\n",li_space*3 SPACES ,"DISPLAY BY NAME ooef001_desc "
                                                           
          END IF   
END FUNCTION 

#+ 處理開窗部分
PRIVATE FUNCTION adzp153_process_open_win(ps_gzsz014,ps_temp,ps_colid)
   DEFINE ps_gzsz014 STRING 
   DEFINE ps_temp STRING
   DEFINE ps_colid STRING
   DEFINE li_cnt     LIKE type_t.num5

  LET li_cnt  = 27
  #mdl_var1
  LET g_trans[li_cnt].code = ps_temp 

  LET li_cnt  =  li_cnt + 1
  #mdl_form
  LET g_trans[li_cnt].code = ps_gzsz014 

  LET li_cnt  =  li_cnt + 1 
  #mdl_field1
  LET g_trans[li_cnt].code = ps_colid 
  #呼叫子樣板組 開窗
  RETURN adzp153_read_slice("ss04") #
END FUNCTION 

#+ 處理 ss03 子樣板
PRIVATE FUNCTION adzp153_code_fragment(lchannel_read)
   DEFINE lchannel_read   base.Channel
   DEFINE ls_text STRING  
   DEFINE ls_read STRING
   DEFINE li_chk_exist  LIKE type_t.num5 
   DEFINE li_chk_extra  LIKE type_t.num5 
   #gi_chk1:校驗 gi_chk2:額外檢查
   LET ls_text = ""
   LET li_chk_exist = FALSE 
   LET li_chk_extra = FALSE 
   WHILE TRUE

      IF lchannel_read.isEof() THEN
         EXIT WHILE
      END IF      
      LET ls_read = lchannel_read.readLine()

      IF ls_read.getIndexOf("#exist-Start-",1) THEN 
         LET li_chk_exist =  TRUE 
         CONTINUE WHILE 
      END IF 

      IF ls_read.getIndexOf("#exist-End-",1) THEN 
         LET li_chk_exist =  FALSE  
         CONTINUE WHILE
      END IF

      IF li_chk_exist THEN 
         #校驗
         IF NOT gi_chk1 THEN 
            CONTINUE WHILE 
         END IF
      END IF 

      IF ls_read.getIndexOf("#extra-Start-",1) THEN 
         LET li_chk_extra =  TRUE  
         CONTINUE WHILE
      END IF

      IF ls_read.getIndexOf("#extra-End-",1) THEN 
         LET li_chk_extra =  FALSE 
         CONTINUE WHILE 
      END IF

      IF li_chk_extra THEN 
         #額外檢查
         IF NOT gi_chk2 THEN 
            CONTINUE WHILE 
         END IF
      END IF
      LET ls_text = ls_text ,ls_read,'\n'
   END WHILE
   
   RETURN ls_text,lchannel_read
END FUNCTION 

#+ aoos010  登入時是否需要產生驗證碼 下面 加入ON ACTION set_func
PRIVATE FUNCTION adzp153_extra_process_aoos010(pi_cnt)
   DEFINE pi_cnt LIKE type_t.num5
   IF g_trans[pi_cnt].tag = "btn_set_func" THEN 
      #ON ACTION set_func 
      #   CALL s_azzi000_set_func("default")。
      LET g_trans[pi_cnt].code = g_trans[pi_cnt].code,"\n",li_space*2 SPACES ,"ON ACTION set_func "
                                                     ,"\n",li_space*3 SPACES,"CALL s_azzi000_set_func(\"","default\"",")" 
   END IF 
END FUNCTION    

#+ 設定額外檢查功能
#+ 1.傳入兩個參數
PRIVATE FUNCTION adzp153_extra_gzsv007(pi_cnt,pc_dzdb001,ps_new,ps_old)
   DEFINE pi_cnt      LIKE type_t.num5
   DEFINE ps_new      STRING 
   DEFINE ps_old      STRING
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE pc_dzdb001  LIKE dzdb_t.dzdb001

   #15/06/08  設定額外檢查功能 元件參數必須傳入兩個參數(新值,舊值) 
   #--SELECT COUNT(dzdb005) INTO li_cnt FROM dzda_t 
   #--INNER JOIN dzdb_t ON dzda001 = dzdb001 
   #  --AND dzdb001 = pc_dzdb001 
   #  --AND dzdb002 = 'P'
   #15/06/08  
   #IF li_cnt = 0 THEN
   #   LET g_trans[pi_cnt].code = pc_dzdb001,"()"  
   #ELSE 
   LET g_trans[pi_cnt].code = pc_dzdb001,"(",ps_new,",",ps_old,")" 
   #END IF    
END FUNCTION 

#+ 產生設定修改後追改功能(gzsv008) 程式片段
PRIVATE FUNCTION adzp153_chk_gzsv008(ps_gzsv008,ps_temp,ps_colid)
   DEFINE ps_gzsv008 STRING 
   DEFINE ps_temp    STRING 
   DEFINE ps_colid   STRING
   DEFINE ls_text    STRING  

   #160503-00009 #1 mark 
   #LET ls_text = "\n",li_space*3 SPACES," IF NOT ",ps_gzsv008,"(",ps_temp,") THEN " ,"\n ",li_space*4 SPACES ,
   #"NEXT FIELD CURRENT \n ",li_space*3 SPACES,"END IF "
   LET ls_text = "\n ",li_space SPACES," IF NOT ",ps_gzsv008,"(",ps_temp,") THEN END IF \n" #160503-00009 #1 add 
   
  RETURN ls_text
END FUNCTION 


PRIVATE FUNCTION adzp153_chk_gzsv007(ps_gzsv007,ps_temp,ps_temp2,ps_colid)
   DEFINE ps_gzsv007  STRING 
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ps_temp     STRING 
   DEFINE ps_temp2    STRING 
   DEFINE ps_colid    STRING
   DEFINE ls_text     STRING 


   IF cl_null(ps_gzsv007) THEN 
      LET ls_text = ""
      RETURN ls_text 
   END IF 

    LET ls_text = "\n",li_space*3 SPACES," IF NOT cl_null (",ps_temp,") THEN " ,"\n ",li_space*4 SPACES ,
                  "\n",li_space*4 SPACES," IF NOT ",ps_gzsv007,"(",ps_temp,") THEN " ,"\n ",li_space*4 SPACES ,
                  "\n",li_space*5 SPACES," INITIALIZE g_errparam TO NULL",
                  "\n",li_space*5 SPACES," LET g_errparam.extend = ",ps_temp,
                  "\n",li_space*5 SPACES," LET g_errparam.code   = \"lib-00407\"",
                  "\n",li_space*5 SPACES," LET g_errparam.popup  = TRUE",
                  "\n",li_space*5 SPACES," CALL cl_err()",
                  "\n",li_space*5 SPACES," NEXT FIELD CURRENT \n ",
                  "\n",li_space*4 SPACES," END IF ",
                  "\n",li_space*3 SPACES," END IF \n" 
   
   RETURN ls_text 
END FUNCTION   

#+ 產生密碼加密程式片段
PRIVATE FUNCTION adzp153_encode(ps_temp,ps_temp_t)
   DEFINE ps_temp_t   STRING 
   DEFINE ps_temp     STRING 
   DEFINE ls_text     STRING 

   LET ls_text = "\n",li_space*4 SPACES,"IF NOT cl_null (",ps_temp,") THEN " ,"\n ",li_space*4 SPACES ,
                 "\n",li_space*5 SPACES ,"IF ",ps_temp," <> ",ps_temp_t ," THEN \n ",li_space*4 SPACES ,
                 "\n",li_space*6 SPACES,"LET ",ps_temp ," = cl_hashkey_user_encode(",ps_temp,") \n",
                 "\n",li_space*5 SPACES,"END IF " ,
                 "\n",li_space*4 SPACES,"END IF "    

   RETURN ls_text
END FUNCTION 



