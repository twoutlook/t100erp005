#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ code_id......: adzp154.4gl
#+ descriptions.: 程式資料建立
#+ code_creator.: hjwang
# Modify.........:2014/07/08 By jrg542                  在aoos010 畫面上要多一顆按鈕，固定產生在 『登入時是否需要產生驗證碼』後面 然後需要產生對應的 code (呼叫 saki 指定的 function s_azzi000_set_func(“default”) 
# Modify.........:2015/06/02 By jrg542                  調整產生4fd 欄位寬度
# Modify.........:2016/03/24 By jrg542                  調整日期格式，DateEdit 增加屬性format="yyyy/mm/dd" picture="####/##/##"
# Modify.........:2017/01/17 By jrg542 #170117-00014 #1 ORDER BY gzsx004,gzsx005 改成 ORDER BY gzsx004,gzsx002,gzsx005,gzsx003 
# Modify.........:2017/01/24 By jrg542 #170124-00020 #1 調整參數產生器 針對據點級參數做處理，只要有據點級參數，可以有切換營運據點的開窗               
# Modify.........:2017/02/10 By jrg542 #170210-00039 #1 增加密碼遮罩功能 目前只針對參數編號S-MFG-0062

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE gdnode_all     om.DomNode
DEFINE ms_module STRING  #模組編號
DEFINE ms_prog   STRING  #程式編號
DEFINE g_gzsx   DYNAMIC ARRAY OF RECORD
         gzsx002  LIKE gzsx_t.gzsx002,   #分頁編號
         gzsx004  LIKE gzsx_t.gzsx004,   #分頁序號
         gzsx003  LIKE gzsx_t.gzsx003,   #分項編號
         gzsx005  LIKE gzsx_t.gzsx005,   #分項序號
         gzsx006  LIKE gzsx_t.gzsx006    #圖標       
                  END RECORD

DEFINE g_gridheight LIKE type_t.num10    #計算4fd  gridHeight:高度(Y軸)
DEFINE g_height     LIKE type_t.num10    #        gridHeight:高度(Y軸)                

DEFINE g_gzsv    DYNAMIC ARRAY OF STRING 

MAIN
   DEFINE ls_sql  STRING
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE li_total LIKE type_t.num5
   DEFINE lc_gzsv001       LIKE gzsv_t.gzsv001
   DEFINE ls_code_filename STRING 

   #adz 模組使用 其他模組 使用cl_ap_init()
   CALL cl_tool_init()

   #取得目前的環境代碼
   LET ms_module = DOWNSHIFT(ARG_VAL(1) CLIPPED)  #模組編號
   LET ms_prog   = DOWNSHIFT(ARG_VAL(2) CLIPPED)  #程式編號
   #查t100debug
   LET g_t100debug = FGL_GETENV("T100DEBUG")
   LET g_height = 7 #grid grid_parametergroup + grid2 gridHeight的高度
   #取出作業的頁次架構
   LET ls_sql = "SELECT gzsx002,gzsx004,gzsx003,gzsx005,gzsx006 FROM gzsx_t ",
                " WHERE gzsx001 = '",ms_prog.trim(),"' ",
                #" ORDER BY gzsx004,gzsx005 "
                " ORDER BY gzsx004,gzsx002,gzsx005,gzsx003 "  
                
   DECLARE adzp154_main_cs CURSOR FROM ls_sql

   #先以分頁 再以分項
   CALL g_gzsx.clear()
   LET li_cnt = 1
   LET lc_gzsv001 = ms_prog
   FOREACH adzp154_main_cs INTO g_gzsx[li_cnt].gzsx002,g_gzsx[li_cnt].gzsx004,g_gzsx[li_cnt].gzsx003,
                                g_gzsx[li_cnt].gzsx005,g_gzsx[li_cnt].gzsx006
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      ELSE
          SELECT  COUNT(*) INTO li_total FROM  gzsv_t  
             WHERE  gzsv001 = lc_gzsv001              #作業
             AND    gzsv002 = g_gzsx[li_cnt].gzsx002  #分頁 
             AND    gzsv003 = g_gzsx[li_cnt].gzsx003  #分項      
         IF li_total = 0 THEN
            CONTINUE FOREACH
         END IF
         LET li_cnt = li_cnt + 1
      END IF
   END FOREACH
   CALL g_gzsx.deleteElement(li_cnt)

   CALL adzp154_read_and_replace() RETURNING ls_code_filename

END MAIN

#+ 程式讀取/程式寫出(xml,同進同出) 
PRIVATE FUNCTION adzp154_read_and_replace()

   DEFINE lddoc_all      om.DomDocument
   DEFINE ls_sample_filename    STRING
   DEFINE ls_code_filename      STRING

   #定義寫入檔案  $ERP/Module/4fd/xxxxx.4fd
   LET ls_code_filename = os.Path.join(os.Path.join(FGL_GETENV("ERP"),ms_module),"4fd")
   LET ls_code_filename = os.Path.join(ls_code_filename,ms_prog||".4fd")

   #定義要讀取的 template 檔案
   #先讀取T100TEMPLATEPATH, 若無則採用$ERP/mdl
   LET ls_sample_filename = FGL_GETENV("T100TEMPLATEPATH") #os.Path.join(FGL_GETENV("ERP"),"mdl")
   IF cl_null(ls_sample_filename) THEN
      LET ls_sample_filename = FGL_GETENV("ERP")
      LET ls_sample_filename = os.Path.join(ls_sample_filename,"mdl")
   END IF
   
   #定義要讀取的 template 檔案
   #LET ls_sample_filename = os.Path.join(FGL_GETENV("ERP"),"mdl")
   LET ls_sample_filename = os.Path.join(ls_sample_filename,"code_s51.template")
   DISPLAY "azdp154:產生器"

   LET lddoc_all = om.DomDocument.createFromXmlFile(ls_sample_filename)  #om.DomDocument

   #若讀取不到資料代表tabx不存在
   TRY
      LET gdnode_all = lddoc_all.getDocumentElement()                #om.DomNode
   CATCH
      DISPLAY "ERROR:讀取",ls_sample_filename,"發生錯誤, 程式中止!"
      EXIT PROGRAM -1
   END TRY

   LET gdnode_all = lddoc_all.getDocumentElement()                #om.DomNode

   CALL adzp154_read_basic_data()
   CALL adzp154_writefile(gdnode_all.toString(),ls_code_filename)
   RETURN ls_code_filename
END FUNCTION


#存檔 改用base.Channel的方式存檔
PRIVATE FUNCTION adzp154_writefile(p_xmlStr,ls_code_filename)

   DEFINE ls_code_filename  STRING
   DEFINE p_xmlStr          STRING
   DEFINE l_ch_out          base.Channel

   #先行移除4gl
   IF os.Path.delete(ls_code_filename) THEN
      DISPLAY "刪除舊檔案:",ls_code_filename
   END IF

   #判斷是否砍除成功
   IF NOT os.Path.exists(ls_code_filename) THEN
      DISPLAY "舊檔案刪除成功:",ls_code_filename
   ELSE
      DISPLAY "Error:舊檔案刪除失敗:",ls_code_filename
      EXIT PROGRAM -1
   END IF

   DISPLAY "目的檔:",ls_code_filename

   LET l_ch_out = base.Channel.create()
   CALL l_ch_out.setDelimiter("")
   CALL l_ch_out.openFile(ls_code_filename,"w")
   CALL l_ch_out.write(p_xmlStr)
   CALL l_ch_out.close()

   #對產生器寫出的檔案權限在UNIX下均全部打開
   IF os.Path.separator() = "/" THEN
      IF os.Path.chrwx(ls_code_filename,511) THEN
      END IF
   END IF
   DISPLAY ls_code_filename,"產生成功!"
END FUNCTION


#+ 取出資料
#+ 1.先處理 undefined 部分
#+ 2.再處理 畫面Form 部分
PRIVATE FUNCTION adzp154_read_basic_data()
   DEFINE ln_record     om.NodeList
   DEFINE l_record      om.DomNode
   DEFINE l_recordfield om.DomNode
   DEFINE l_record_child om.DomNode
   DEFINE l_child       om.DomNode
   #DEFINE empty         om.DomDocument
   DEFINE l_other       om.DomNode
   DEFINE li_pos        LIKE type_t.num10
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE ls_name       STRING
   DEFINE li_page       LIKE type_t.num5
   DEFINE li_item       LIKE type_t.num5
   DEFINE ls_grid       STRING
   DEFINE li_gridend    LIKE type_t.num5
   DEFINE li_gridposy   LIKE type_t.num5   #Grid控件內部的Y軸高度
   DEFINE li_seq        LIKE type_t.num5
   DEFINE li_gridheight LIKE type_t.num5
   DEFINE li_posy       LIKE type_t.num5
   DEFINE ls_image      STRING 
   DEFINE li_chk      LIKE type_t.num5            #170124-00020 #1

   #取得ooab_t 設定的參數程式
   CALL sadzp153_get_gzsv001(ms_prog) RETURNING g_gzsv   #170124-00020 #1
      
   #取出om.NodeList 有關Record tag list   
   LET ln_record = gdnode_all.selectByTagName("Record")
   #處理4fd 畫面結構 Undefined 部分
   #處理Record 
   CALL adzp154_process_4fd_undefined(ln_record) RETURNING li_seq

   #取出om.NodeList 有關Grid tag list
   LET ln_record = gdnode_all.selectByTagName("Grid")
   #處理4fd 畫面結構 Grid1 部分
   #處理Record
   CALL adzp154_process_4fd_grid(ln_record) 
   
   #取出om.NodeList 有關VBox tag list
   LET ln_record = gdnode_all.selectByTagName("VBox")
   #處理4fd 畫面結構 VBox 部分
   #處理Record
   CALL adzp154_process_4fd_vbox(ln_record) 

END FUNCTION

#+ 產生變數Record內相關資料,全部產生在Undefine群組內
PRIVATE FUNCTION adzp154_gen_recordfield(l_record,li_cnt,li_seq,li_chk,l_gzsv)
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE l_record    om.DomNode
   DEFINE l_recordfield     om.DomNode
   DEFINE li_pos      LIKE type_t.num5
   DEFINE ls_sql      STRING
   DEFINE lc_gzsz002  LIKE gzsz_t.gzsz002
   DEFINE lc_gzsz003  LIKE gzsz_t.gzsz003
   DEFINE ls_name     STRING
   DEFINE li_seq      LIKE type_t.num5
   DEFINE li_chk      LIKE type_t.num5
   DEFINE li_posy     LIKE type_t.num5
   DEFINE lc_gzsz001  LIKE gzsz_t.gzsz001
   DEFINE l_gzsv  RECORD 
      gzsv004 LIKE  gzsv_t.gzsv004,
      gzsv005 LIKE  gzsv_t.gzsv005,
      gzsv006 LIKE  gzsv_t.gzsv006 
   END RECORD 
   
   LET ls_sql = "SELECT gzsz002,gzsz003 FROM gzsz_t ",
                " WHERE gzsz001 = '",l_gzsv.gzsv005,"' ",                     #表格編號
                  " AND gzsz002 = '",l_gzsv.gzsv006 CLIPPED,"' ",             #參數編號
                  " AND gzszstus = 'Y' ",                                     #有效碼
                " ORDER BY gzsz005 "                                          #排序             

   DECLARE adzp154_gen_recordfield_cs CURSOR FROM ls_sql
   LET li_pos = 1
   #170124-00020 #1 start
   #當是據點級aoos020 且 li_chk = true  額外加入 ooef001 可切外營運中心  RecordField
   #15/06/30 加入 ains010、apms010、apss010、aqcs010、asfs010、axms010
   #IF (ms_prog = "aoos020" OR ms_prog = "ains010" OR ms_prog = "apms010" OR ms_prog = "apss010" OR ms_prog = "aqcs010" OR ms_prog = "asfs010" OR ms_prog = "axms010" OR ms_prog = "bphs020_ph" )AND li_chk THEN
   IF li_chk THEN
   #170124-00020 #1 end  
      LET l_recordfield = l_record.createChild("RecordField")
      CALL l_recordfield.setAttribute("colName","ooef001")
      CALL l_recordfield.setAttribute("fieldIdRef",li_seq)
      CALL l_recordfield.setAttribute("fieldType","NON_DATABASE")
      CALL l_recordfield.setAttribute("name","ooef001")
      CALL l_recordfield.setAttribute("length","50")
      
      CALL l_recordfield.setAttribute("sqlTabName","")
      CALL l_recordfield.setAttribute("sqlType","CHAR")
      CALL l_recordfield.setAttribute("table_alias_name","")       
      #只加一次就可以 ooef001
      LET li_chk = FALSE 
      #第四個給 FFLABEL 其他從第五個開始
      LET li_seq = li_seq + 1
      LET l_recordfield = l_record.createChild("RecordField")
      CALL l_recordfield.setAttribute("colName","")
      CALL l_recordfield.setAttribute("defaultValue","")
      CALL l_recordfield.setAttribute("fieldIdRef",li_seq)
      CALL l_recordfield.setAttribute("fieldType","NON_DATABASE")
      CALL l_recordfield.setAttribute("name","ooef001_desc")
      CALL l_recordfield.setAttribute("precision","4")
      
      CALL l_recordfield.setAttribute("precisionDecimal","16") 
      CALL l_recordfield.setAttribute("qual1","YEAR") 
      CALL l_recordfield.setAttribute("qual2","YEAR") 
      CALL l_recordfield.setAttribute("qualFraction","YEAR") 
      CALL l_recordfield.setAttribute("scale","3") 
      CALL l_recordfield.setAttribute("scaleDecimal","-1") 
      CALL l_recordfield.setAttribute("scale","") 
      CALL l_recordfield.setAttribute("table_alias_name","") 

      LET li_seq = li_seq + 1    
   END IF
   #DISPLAY "gzsv005 ",l_gzsv.gzsv005 , "  gzsv006 ", l_gzsv.gzsv006 
   FOREACH adzp154_gen_recordfield_cs INTO lc_gzsz002,lc_gzsz003 
      LET l_recordfield = l_record.createChild("RecordField")
      CALL l_recordfield.setAttribute("colName","")
      CALL l_recordfield.setAttribute("fieldIdRef",li_seq)
      CALL l_recordfield.setAttribute("fieldType","NON_DATABASE")
      CALL l_recordfield.setAttribute("length","80")
      LET ls_name = g_gzsx[li_cnt].gzsx002 CLIPPED,
                "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",l_gzsv.gzsv004 USING "<<<<"
      CALL l_recordfield.setAttribute("name",ls_name)
      CALL l_recordfield.setAttribute("sqlTabName","")
      CALL l_recordfield.setAttribute("sqlType","VARCHAR")
      CALL l_recordfield.setAttribute("table_alias_name","")
      LET li_seq = li_seq + 1
      #LET li_pos = li_pos + 1

   END FOREACH 
   IF cl_null(lc_gzsz002) THEN
      DISPLAY "Error:在azzi990 參數資料定義作業，無此筆資料 表格:",l_gzsv.gzsv005 ," 參數編號:", l_gzsv.gzsv006 ," ,請確認" 
      DISPLAY "adzp154 程式中止!"
      EXIT PROGRAM -1
   END IF 
   RETURN li_seq,li_chk

END FUNCTION


PRIVATE FUNCTION adzp154_data_item_undefined_prepare(l_dom,li_cnt,li_seq,li_chk)
   DEFINE l_dom       om.DomNode
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE li_seq      LIKE type_t.num5   
   DEFINE li_chk      LIKE type_t.num5
   DEFINE li_posy     LIKE type_t.num5
   DEFINE lc_gzsv001  LIKE gzsv_t.gzsv001
   DEFINE lc_gzsv002  LIKE gzsv_t.gzsv002
   DEFINE lc_gzsv003  LIKE gzsv_t.gzsv003
   DEFINE lc_gzsv004  LIKE gzsv_t.gzsv004
   DEFINE lc_gzsv005  LIKE gzsv_t.gzsv005
   DEFINE lc_gzsv006  LIKE gzsv_t.gzsv006
   DEFINE l_gzsv  RECORD 
      gzsv004 LIKE  gzsv_t.gzsv004,
      gzsv005 LIKE  gzsv_t.gzsv005,
      gzsv006 LIKE  gzsv_t.gzsv006 
   END RECORD 
   DEFINE ls_sql      STRING
   DEFINE ps_tag      STRING 
   
   LET ls_sql = "SELECT  gzsv004,gzsv005,gzsv006 ",
                " FROM  gzsv_t ",
                " WHERE  gzsv001 ='",ms_prog.trim(),"'" ,
                " AND  gzsv002 = ? " ,
                " AND  gzsv003 = ? ",
                " ORDER BY gzsv004 "

  PREPARE adzp154_data_item_undefined_pre FROM  ls_sql
  DECLARE adzp154_data_item_undefined_cs CURSOR FOR adzp154_data_item_undefined_pre
  OPEN adzp154_data_item_undefined_cs USING g_gzsx[li_cnt].gzsx002,g_gzsx[li_cnt].gzsx003

  FOREACH adzp154_data_item_undefined_cs INTO l_gzsv.gzsv004,l_gzsv.gzsv005,l_gzsv.gzsv006
     CALL adzp154_gen_recordfield(l_dom,li_cnt,li_seq,li_chk,l_gzsv.*) RETURNING li_seq,li_chk
  END FOREACH 
  
  CLOSE adzp154_data_item_undefined_cs 
  FREE adzp154_data_item_undefined_pre
  RETURN li_seq,li_chk
END FUNCTION 


PRIVATE FUNCTION adzp154_data_item_group_prepare(l_dom,li_cnt,li_seq,li_chk)
   DEFINE l_dom       om.DomNode
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE li_seq      LIKE type_t.num5   
   DEFINE li_chk      LIKE type_t.num5
   DEFINE li_posy     LIKE type_t.num5
   DEFINE lc_gzsv001  LIKE gzsv_t.gzsv001
   DEFINE lc_gzsv002  LIKE gzsv_t.gzsv002
   DEFINE lc_gzsv003  LIKE gzsv_t.gzsv003
   DEFINE l_gzsv  RECORD 
      gzsv004 LIKE  gzsv_t.gzsv004,
      gzsv005 LIKE  gzsv_t.gzsv005,
      gzsv006 LIKE  gzsv_t.gzsv006 
   END RECORD
   DEFINE ls_sql      STRING
   DEFINE ps_tag      STRING 

   LET ls_sql = "SELECT  gzsv004,gzsv005,gzsv006 ",
                " FROM  gzsv_t ",
                " WHERE  gzsv001 ='",ms_prog.trim(),"'" ,
                " AND  gzsv002 = ? " ,
                " AND  gzsv003 = ? ",
                " ORDER BY gzsv004 "

  PREPARE adzp154_data_item_group_pre FROM  ls_sql
  DECLARE adzp154_data_item_group_cs CURSOR FOR adzp154_data_item_group_pre
  LET li_posy = 0
  OPEN adzp154_data_item_group_cs USING g_gzsx[li_cnt].gzsx002,g_gzsx[li_cnt].gzsx003
  FOREACH adzp154_data_item_group_cs INTO l_gzsv.gzsv004,l_gzsv.gzsv005,l_gzsv.gzsv006
     IF g_t100debug = "9" THEN
         DISPLAY "gzsv004(序號):", l_gzsv.gzsv004," gzsv005(表格名稱):",l_gzsv.gzsv005 ," gzsv006(參數編號):",l_gzsv.gzsv006
     END IF
     CALL adzp154_gen_group(l_dom,li_cnt,li_seq,li_posy,li_chk,l_gzsv.*) RETURNING li_seq,li_posy,li_chk
  END FOREACH 
  
  CLOSE adzp154_data_item_group_cs 
  FREE adzp154_data_item_group_pre
  RETURN li_seq,li_posy,li_chk
END FUNCTION 


#+ 產生每個分項下方的設定節點        
PRIVATE FUNCTION adzp154_gen_group(l_group,li_cnt,li_seq,li_posy,li_chk,l_gzsv)
   DEFINE l_group     om.DomNode
   DEFINE l_child     om.DomNode
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE li_pos      LIKE type_t.num5
   DEFINE lc_gzsz001  LIKE gzsz_t.gzsz001 #表格編號
   DEFINE lc_gzsz002  LIKE gzsz_t.gzsz002 #參數編號
   DEFINE lc_gzsz003  LIKE gzsz_t.gzsz003 #輸入限制資料型態 
   DEFINE lc_gzsz016  LIKE gzsz_t.gzsz016 #值域範圍說明(SCC) 
   DEFINE lc_gzsz014  LIKE gzsz_t.gzsz014 #開窗設定
   DEFINE li_seq      LIKE type_t.num5    #產生fieldId序號(須連續)
   DEFINE li_posy     LIKE type_t.num5    #widget起始位置
   DEFINE ls_name     STRING
   DEFINE ls_sql      STRING
   DEFINE li_chk      LIKE type_t.num5
   DEFINE li_chk_gzsz016 LIKE type_t.num5
   DEFINE l_gzsv  RECORD 
      gzsv004 LIKE  gzsv_t.gzsv004,
      gzsv005 LIKE  gzsv_t.gzsv005,
      gzsv006 LIKE  gzsv_t.gzsv006 
   END RECORD

   LET ls_sql = "SELECT gzsz002,gzsz003,gzsz014,gzsz016 FROM gzsz_t ",
                " WHERE gzsz001 = '",l_gzsv.gzsv005 CLIPPED,"' ",     #表格編號
                  " AND gzsz002 = '",l_gzsv.gzsv006 CLIPPED,"' ",     #分頁
                  " AND gzszstus = 'Y' ",                             #有效碼
                " ORDER BY gzsz005 "                                  #排序
                
   DECLARE adzp154_gen_group_cs CURSOR FROM ls_sql
   LET li_pos = 1
   #LET li_posy = 0

   #在Group下1:先建立Button #除了CheckBox 之外 都要加Label
   #        2:以gzsz016 是否有SCC建立ComboBox 
   #        3:以gzsz003 決定哪些控件 
   FOREACH adzp154_gen_group_cs INTO lc_gzsz002,lc_gzsz003,lc_gzsz014,lc_gzsz016
      #目前先以 Button 為控件
      LET l_child = l_group.createChild("Button")
      LET ls_name = "help_",g_gzsx[li_cnt].gzsx002 CLIPPED,
                    "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",l_gzsv.gzsv004 USING "<<<<"

      LET li_posy = li_posy + 1
      CALL l_child.setAttribute("gridHeight","1")
      CALL l_child.setAttribute("gridWidth","2")
      CALL l_child.setAttribute("image","16/s_help.png")
      CALL l_child.setAttribute("name",ls_name)
      CALL l_child.setAttribute("posX","1")
      CALL l_child.setAttribute("posY",li_posy)
      CALL l_child.setAttribute("style","noBorder")
      CALL l_child.setAttribute("tabIndex","")

      #除了CheckBox 之外 都要加Label
      IF lc_gzsz003 <> "1" THEN 
         LET l_child = l_group.createChild("Label")
         LET ls_name = "lbl_",g_gzsx[li_cnt].gzsx002 CLIPPED,
                       "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",l_gzsv.gzsv004 USING "<<<<"
         CALL l_child.setAttribute("gridHeight","1")
         CALL l_child.setAttribute("gridWidth","21")
         CALL l_child.setAttribute("name",ls_name)
         CALL l_child.setAttribute("posX","4")
         CALL l_child.setAttribute("posY",li_posy)
         CALL l_child.setAttribute("text",ls_name)
         LET li_posy = li_posy + 1 
      END IF 

      #處理不同的輸入型態
      #gzsz016 有在scc 就以ComboBox產生
      LET li_chk_gzsz016 = sadzp153_chk_gzsz016(lc_gzsz016)
      IF g_t100debug = "9" THEN
         DISPLAY "是否有SCC:",li_chk_gzsz016 ,"(1:有0:沒有) SCC 代碼:",lc_gzsz016
      END IF
   
      IF li_chk_gzsz016 THEN 
         #CALL adzp154_add_widget_attr()
         LET l_child = l_group.createChild("ComboBox")
         CALL l_child.setAttribute("scroll", "true") #避免出現的字串被截斷 
         CALL l_child.setAttribute("widget","ComboBox")
         CALL l_child.setAttribute("notNull","true") 
         CALL l_child.setAttribute("comment",lc_gzsz002 CLIPPED)
         CALL l_child.setAttribute("gridWidth","15")
         #CALL adzp153_add_widget_attr(l_group,li_chk_gzsz016,lc_gzsz003)
      ELSE 
         #輸入限制資料型態
         CASE 
         #Y/N
            WHEN lc_gzsz003 = "1" 
               LET ls_name = "lbl_",g_gzsx[li_cnt].gzsx002 CLIPPED,
                            "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",l_gzsv.gzsv004 USING "<<<<"
          
               LET l_child = l_group.createChild("CheckBox")
               CALL l_child.setAttribute("widget","CheckBox") 
               CALL l_child.setAttribute("text",ls_name) 
               CALL l_child.setAttribute("notNull","true")
               CALL l_child.setAttribute("comment",lc_gzsz002 CLIPPED)
               CALL l_child.setAttribute("lstrcomment","true")
               CALL l_child.setAttribute("valueChecked", "Y")
               CALL l_child.setAttribute("valueUnchecked","N")
               CALL l_child.setAttribute("posX","4")
               CALL l_child.setAttribute("posY",li_posy)
               CALL l_child.setAttribute("gridWidth","10")
           #整數選項  #範圍設定  #字元
           WHEN lc_gzsz003 = "2" OR lc_gzsz003 = "3" OR lc_gzsz003 = "4"
               #若有設定開窗(gzsz014)欄位  改用BUTTONEDIT  
               IF cl_null(lc_gzsz014) THEN 
                  LET l_child = l_group.createChild("Edit")
                  CALL l_child.setAttribute("widget","Edit")
                  CALL l_child.setAttribute("scroll","true")
                  CALL l_child.setAttribute("comment",lc_gzsz002 CLIPPED)  

                  #2017/02/10 apss010 特別處理 參數是S-MFG-0062 要額外加入 invisible 屬性
                  IF lc_gzsz002 = "S-MFG-0062" THEN  
                     CALL l_child.setAttribute("invisible","true")
                  END IF 
                  #2017/02/10      
               ELSE
                  LET l_child = l_group.createChild("ButtonEdit")
                  CALL l_child.setAttribute("widget","ButtonEdit")
                  CALL l_child.setAttribute("action","controlp")
                  CALL l_child.setAttribute("lstrtitle","true")
                  CALL l_child.setAttribute("noEntry","false")
                  CALL l_child.setAttribute("notNull","false")
                  CALL l_child.setAttribute("notNull","false")
                  CALL l_child.setAttribute("required","false")
                  CALL l_child.setAttribute("repeat","false")
                  CALL l_child.setAttribute("columnCount","")
                  CALL l_child.setAttribute("rowCount","")
                  CALL l_child.setAttribute("stepX","")
                  CALL l_child.setAttribute("stepY","")
                  CALL l_child.setAttribute("image","16/openwindow.png")
                  CALL l_child.setAttribute("hidden","")
                  CALL l_child.setAttribute("scroll","true")
                  CALL l_child.setAttribute("style","")
                  CALL l_child.setAttribute("comment",lc_gzsz002 CLIPPED)
                  CALL l_child.setAttribute("lstrcomment","true")
                  CALL l_child.setAttribute("sqlTabName","")
               END IF 
               CALL l_child.setAttribute("gridWidth","23")
           #日期
           WHEN lc_gzsz003 = "5" 
              LET l_child = l_group.createChild("DateEdit")      
              CALL l_child.setAttribute("noEntry","false")
              CALL l_child.setAttribute("repeat","false")
              CALL l_child.setAttribute("title","DateEdit1")
              CALL l_child.setAttribute("widget","DateEdit")
              CALL l_child.setAttribute("scroll","true")
              CALL l_child.setAttribute("comment",lc_gzsz002 CLIPPED)
              CALL l_child.setAttribute("format","yyyy/mm/dd") 
              CALL l_child.setAttribute("picture","####/##/##")  
              CALL l_child.setAttribute("gridWidth","14")
        END CASE 
      END IF 

      #170124-00020 #1 start 
      #aoos020 因 fieldIdRef = fieldId 其他從第5開始
      #15/06/30 加入 ains010、apms010、apss010、aqcs010、asfs010、axms010
      #IF (ms_prog = "aoos020" OR ms_prog = "ains010" OR ms_prog = "apms010" OR ms_prog = "apss010" OR ms_prog = "aqcs010" OR ms_prog = "asfs010" OR ms_prog = "axms010" OR ms_prog = "bphs020_ph" ) AND li_chk THEN
      #據點級參數
      IF li_chk THEN
      #170124-00020 #1 end
         LET li_seq = li_seq + 1  
         LET li_chk = FALSE  
      END IF

      LET ls_name = g_gzsx[li_cnt].gzsx002 CLIPPED,
                      "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",l_gzsv.gzsv004 USING "<<<<"
            
      CALL l_child.setAttribute("aggregateColName","")
      CALL l_child.setAttribute("aggregateName","")
      CALL l_child.setAttribute("aggregateTableAliasName","")
      CALL l_child.setAttribute("aggregateTableName","")
      CALL l_child.setAttribute("fieldId",li_seq)
      CALL l_child.setAttribute("gridHeight","1")
      #lc_gzsz003 輸入限制資料型態 
      #15/06/02 調整欄位寬度
      --IF lc_gzsz003 = "5" THEN #日期
         --CALL l_child.setAttribute("gridWidth","14")
      --ELSE
         --CALL l_child.setAttribute("gridWidth","10")
      --END IF
      #15/06/02 
      CALL l_child.setAttribute("name",ls_name)
      CALL l_child.setAttribute("posX","4")
      CALL l_child.setAttribute("posY",li_posy)
      CALL l_child.setAttribute("tabIndex","")

      #aoos010 特別處理  參數是E-SYS-0033 額外加入button 
      IF lc_gzsz002 = "E-SYS-0033" THEN #登入時是否需要輸入驗證碼 
         LET l_child = l_group.createChild("Button")
         LET ls_name = "set_func" CLIPPED
         LET li_posy = li_posy + 1
         CALL l_child.setAttribute("gridHeight","1")
         CALL l_child.setAttribute("gridWidth","10")
         CALL l_child.setAttribute("image","")
         CALL l_child.setAttribute("name",ls_name)
         CALL l_child.setAttribute("posX","4")
         CALL l_child.setAttribute("posY",li_posy)
         CALL l_child.setAttribute("style","")
         CALL l_child.setAttribute("tabIndex","")
         CALL l_child.setAttribute("text","btn_"||ls_name)
      END IF 

 
      
      LET li_seq = li_seq + 1
   END FOREACH
   IF cl_null(lc_gzsz002) THEN
      DISPLAY "Error:在azzi990 參數資料定義作業，無此筆資料 表格:",l_gzsv.gzsv005 ," 參數編號:", l_gzsv.gzsv006 ," ,請確認" 
      DISPLAY "adzp154 程式中止!"
      EXIT PROGRAM -1
   END IF 
   RETURN li_seq,li_posy,li_chk
END FUNCTION

#+ 處理4fd 畫面結構 Undefined 部分
PRIVATE FUNCTION adzp154_process_4fd_undefined(ln_record)
   DEFINE ln_record     om.NodeList
   DEFINE l_record      om.DomNode
   DEFINE li_seq        LIKE type_t.num5
   DEFINE li_pos        LIKE type_t.num5
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE li_chk        LIKE type_t.num5
   DEFINE li_posy       LIKE type_t.num5

   #170124-00020 #1 start
   LET li_chk = FALSE 
   #15/06/30 加入 ains010、apms010、apss010、aqcs010、asfs010、axms010
   #IF ms_prog = "aoos020" OR ms_prog = "ains010" OR ms_prog = "apms010" OR ms_prog = "apss010" OR ms_prog = "aqcs010" OR ms_prog = "asfs010" OR ms_prog = "axms010" OR ms_prog = "bphs020_ph" THEN 
   #   LET li_chk = TRUE 
   #END IF 
   #判斷據點級參數
   FOR li_cnt = 1 TO g_gzsv.getLength()
       IF ms_prog = g_gzsv[li_cnt] THEN 
          LET li_chk = TRUE 
          EXIT FOR
       END IF 
   END FOR 
   IF g_t100debug = "9" THEN
      DISPLAY "據點級參數(1:是/0:不是):",li_chk ," prog:",ms_prog
   END IF
   #170124-00020 #1 end
   
   #處理Record
   FOR li_pos = 1 TO ln_record.getLength()
      LET l_record = ln_record.item(li_pos)
      IF l_record.getAttribute("name") = "Undefined" THEN
         LET li_seq = 4 #前3個已被使用 #helptitle、helpdesc、s_title  aoos020 第4個 Button Edit 第5個 FFLABL 其他 從第五個開始
         FOR li_cnt = 1 TO g_gzsx.getLength()
            CALL adzp154_data_item_undefined_prepare(l_record,li_cnt,li_seq,li_chk) RETURNING li_seq,li_chk
         END FOR
      END IF
   END FOR
   #IF g_t100debug = "9" THEN
   #   FOR li_cnt = 1 TO g_gzsx.getLength()
   #       DISPLAY "gzsx002:",g_gzsx[li_cnt].gzsx002 , " gzsx003:", g_gzsx[li_cnt].gzsx003 ," gzsx004:", g_gzsx[li_cnt].gzsx004 ," gzsx005:",g_gzsx[li_cnt].gzsx005," gzsx006:",g_gzsx[li_cnt].gzsx006
   #   END FOR
   #END IF
   RETURN li_seq
END FUNCTION 

#+ 處理4fd 畫面結構 Grid1 部分
PRIVATE FUNCTION adzp154_process_4fd_grid(ln_record)
  DEFINE ln_record      om.NodeList
  DEFINE l_recordfield  om.DomNode
  DEFINE l_record       om.DomNode
  DEFINE li_pos         LIKE type_t.num5 
  DEFINE li_posy        LIKE type_t.num5
  DEFINE li_cnt         LIKE type_t.num5
  DEFINE ls_grid        STRING 
  DEFINE ls_image       STRING 

   #處理Record
   FOR li_pos = 1 TO ln_record.getLength()
      LET l_record = ln_record.item(li_pos)
      IF l_record.getAttribute("name") = "Grid1" THEN

         LET li_posy = 1
         LET ls_grid = " "
         #分頁處理 (濾除分項)
         FOR li_cnt = 1 TO g_gzsx.getLength()
            #取換頁時才進行作出Button的動作
            IF g_gzsx[li_cnt].gzsx002 <> ls_grid THEN
               IF g_gzsx[li_cnt].gzsx002 IS NOT NULL THEN 
                  #此處用pipe主要是若內容為空,整段就給他空...
                  LET ls_image = "32/s_"||g_gzsx[li_cnt].gzsx006||".png"
                  LET l_recordfield = l_record.createChild("Button")
                  LET li_posy = li_posy + 2
                  CALL l_recordfield.setAttribute("gridHeight","1")
                  CALL l_recordfield.setAttribute("gridWidth","14")
                  CALL l_recordfield.setAttribute("image",ls_image)
                  CALL l_recordfield.setAttribute("name",g_gzsx[li_cnt].gzsx002)
                  CALL l_recordfield.setAttribute("posX","3")
                  CALL l_recordfield.setAttribute("posY",li_posy)
                  CALL l_recordfield.setAttribute("style","menuitem")
                  CALL l_recordfield.setAttribute("tabIndex","")
                  CALL l_recordfield.setAttribute("text","btn_"||g_gzsx[li_cnt].gzsx002)
               END IF
               LET ls_grid = g_gzsx[li_cnt].gzsx002
            END IF
         END FOR

         #處理畫面最下方公版需要的Label
         LET l_recordfield = l_record.createChild("Label")
         LET li_posy = li_posy + 2
         CALL l_recordfield.setAttribute("gridHeight","1")
         CALL l_recordfield.setAttribute("gridWidth","14")
         CALL l_recordfield.setAttribute("name","lbl_space_04")
         CALL l_recordfield.setAttribute("posX","3")           #因 button posX:3 所以 Label 從 posX:3 開始
         CALL l_recordfield.setAttribute("posY",li_posy)
         CALL l_recordfield.setAttribute("text","")

      END IF
   END FOR
END FUNCTION   

#+處理4fd 畫面結構 VBox 的部分
PRIVATE FUNCTION adzp154_process_4fd_vbox(ln_record)
   DEFINE ln_record      om.NodeList
   DEFINE l_record       om.DomNode 
   DEFINE li_chk         LIKE type_t.num5
   DEFINE li_seq         LIKE type_t.num5
   DEFINE li_pos         LIKE type_t.num5
   DEFINE l_other        om.DomNode
   DEFINE l_parent       om.DomNode
   DEFINE ls_grid        STRING
   DEFINE li_page        LIKE type_t.num5 
   DEFINE li_gridposy    LIKE type_t.num5   #Grid控件內部的Y軸高度
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE l_child        om.DomNode
   DEFINE ls_name        STRING 
   DEFINE li_item        LIKE type_t.num5
   DEFINE li_gridheight  LIKE type_t.num5
 

   LET li_chk = FALSE 
   #判斷據點級參數
   FOR li_cnt = 1 TO g_gzsv.getLength()
       IF ms_prog = g_gzsv[li_cnt] THEN 
          LET li_chk = TRUE 
          EXIT FOR
       END IF 
   END FOR 
   
   #處理Grid
   LET li_seq = 4     #前3個已被使用 #helptitle、helpdesc、s_title
   #LET li_chk = TRUE 
   FOR li_pos = 1 TO ln_record.getLength()
      LET l_record = ln_record.item(li_pos)

      #170124-00020 #1 start
      #針對azzs020 特別處理
      #在vbox3 第一個Child 之前 插入Grid(裡面是 Label ButtonEdit FFLABEL)
      #15/06/30 加入 ains010、apms010、apss010、aqcs010、asfs010、axms010
      #IF l_record.getAttribute("name") = "vbox3" AND (ms_prog = "aoos020" OR ms_prog = "ains010" OR ms_prog = "apms010" OR ms_prog = "apss010" OR ms_prog = "aqcs010" OR ms_prog = "asfs010" OR ms_prog = "axms010" OR ms_prog = "bphs020_ph"   ) THEN 
      IF l_record.getAttribute("name") = "vbox3" AND li_chk  THEN
         #有據點級參數要有營運據點可以切換 
         CALL adzp154_process_4fd_vbox3(l_record) RETURNING li_gridposy
      END IF
      #170124-00020 #1 end 
      
      #+處理4fd 畫面結構 VBox1 的部分
      IF l_record.getAttribute("name") = "vbox1" THEN
         LET g_gridheight = l_record.getAttribute("gridHeight")
         LET ls_grid = " "
         #170124-00020 #1 start
         #針對azzs020 特別處理
         #15/06/30 加入 ains010、apms010、apss010、aqcs010、asfs010、axms010
         #IF (ms_prog = "aoos020" OR ms_prog = "ains010" OR ms_prog = "apms010" OR ms_prog = "apss010" OR ms_prog = "aqcs010" OR ms_prog = "asfs010" OR ms_prog = "axms010" OR ms_prog = "bphs020_ph" ) THEN
         IF li_chk THEN
            #有據點級參數 順序第5開使
            LET li_seq = 5 #前4個已被使用 #helptitle、helpdesc、s_title aoos020 第4個 Button Edit 
            #LET li_chk = TRUE
         END IF 
         #170124-00020 #1 end

         #+處理4fd 畫面結構 VBox1 的部分
         #li_gridposy:處理 gridHeight 高度
         CALL adzp154_process_4fd_vbox1(l_record,li_seq,ls_grid,li_gridposy,li_chk) 

         #重算resize
         IF g_gridheight < g_height THEN 
            LET g_height = g_height + 5
            CALL l_record.setAttribute("gridHeight",g_height)
            CALL adzp154_container_resize(l_record)
         END IF 
      END IF
   END FOR 
   CALL adzp154_process_resize_vbox(ln_record)   
END FUNCTION

#+ 在vbox3 第一個Child 之前 插入Grid
#+ 在Grid 下 Child建立 Label
#+ 在Grid 下 Child建立 ButtonEdit
#+ 在Grid 下 Child建立 FFLABEL
#注意:有據點參數才會call 此fcunction 
PRIVATE FUNCTION adzp154_process_4fd_vbox3(l_record)
   DEFINE l_other       om.DomNode
   DEFINE l_record      om.DomNode
   DEFINE l_recordfield om.DomNode
   DEFINE ls_name       STRING 
   DEFINE li_gridposy   LIKE type_t.num5   #Grid控件內部的Y軸高度   
   DEFINE li_page       LIKE type_t.num5
   DEFINE l_record_child om.DomNode
   DEFINE ls_image      STRING 
   
   #取得vbox3 第一個Child
   LET l_other = l_record.getFirstChild() 
   #建一個Grid  
   LET l_recordfield = l_record.createChild("Grid")
         
   LET ls_name = "grid_aoos020",li_page USING "<<<<"
   LET li_gridposy = li_gridposy + 1
   CALL l_recordfield.setAttribute("gridHeight","1")
   CALL l_recordfield.setAttribute("gridWidth","35")
   CALL l_recordfield.setAttribute("hidden","false")
   CALL l_recordfield.setAttribute("name",ls_name)
   CALL l_recordfield.setAttribute("posX","0")
   CALL l_recordfield.setAttribute("posY",li_gridposy)
   CALL l_recordfield.setAttribute("style","parameterbox")

   #回填總使用Y軸長度
   LET li_gridposy = li_gridposy + 1
   
   #在Grid 下 Child建立 Label
   LET l_record_child = l_recordfield.createChild("Label")
   LET ls_name = "Label",li_page USING "<<<<","grid"
   CALL l_record_child.setAttribute("gridHeight","1")
   CALL l_record_child.setAttribute("gridWidth","10")
   CALL l_record_child.setAttribute("name",ls_name)
   CALL l_record_child.setAttribute("posX","1")
   CALL l_record_child.setAttribute("posY",li_gridposy)
   CALL l_record_child.setAttribute("sizePolicy","fixed")
   CALL l_record_child.setAttribute("text","lbl_site")
         
   #在Grid 下 Child建立 ButtonEdit
   LET ls_image = "16/openwindow.png"
   LET l_record_child = l_recordfield.createChild("ButtonEdit")
   CALL l_record_child.setAttribute("gridHeight","1")
   CALL l_record_child.setAttribute("gridWidth","10") 
   CALL l_record_child.setAttribute("action", "controlp")
   CALL l_record_child.setAttribute("colName", "ooef001")
   CALL l_record_child.setAttribute("columnCount", "")
   CALL l_record_child.setAttribute("comment", "columnCount")
   CALL l_record_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_record_child.setAttribute("sqlTabName", "")
   CALL l_record_child.setAttribute("name", "ooef001")
   CALL l_record_child.setAttribute("lstrtext","true")
   CALL l_record_child.setAttribute("lstrcomment","true")
   CALL l_record_child.setAttribute("image",ls_image)

   CALL l_record_child.setAttribute("comment","")
   CALL l_record_child.setAttribute("hidden","false")
   CALL l_record_child.setAttribute("fontPitch","variable")
   CALL l_record_child.setAttribute("posX","12")
   CALL l_record_child.setAttribute("posY",li_gridposy)
   CALL l_record_child.setAttribute("style","")
   CALL l_record_child.setAttribute("fieldId","4")                #前3個已被使用 #helptitle、helpdesc、s_title  aoos020、ains010、apms010、apss010、aqcs010、asfs010、axms010 bphs020_ph 第4個 Button Edit 第5個 FFLABL 其他 從第五個開始
   CALL l_record_child.setAttribute("sizePolicy","initial")
   CALL l_record_child.setAttribute("tabIndex","")
   CALL l_record_child.setAttribute("text","lbl_ok")
   CALL l_record_child.setAttribute("widget", "ButtonEdit")

   #在Grid 下 Child建立 FFLABEL
   LET l_record_child = l_recordfield.createChild("FFLabel")   
   CALL l_record_child.setAttribute("aggregateColName", "")
   CALL l_record_child.setAttribute("aggregateName", "")
   CALL l_record_child.setAttribute("aggregateTableAliasName", "")
   CALL l_record_child.setAttribute("aggregateTableName", "")
   CALL l_record_child.setAttribute("blink", "false")
   CALL l_record_child.setAttribute("colName", "")
   CALL l_record_child.setAttribute("color", "black")
   CALL l_record_child.setAttribute("colorCondition", "")
   CALL l_record_child.setAttribute("columnCount", "2")
   CALL l_record_child.setAttribute("comment", "")
   CALL l_record_child.setAttribute("fieldId", "5")             #前3個已被使用 #helptitle、helpdesc、s_title  aoos020、ains010、apms010、apss010、aqcs010、asfs010、axms010 bphs020_ph 第4個 Button Edit 第5個 FFLABL 其他 從第五個開始
   CALL l_record_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_record_child.setAttribute("fontPitch", "variable")
   CALL l_record_child.setAttribute("gridHeight", "1")
   CALL l_record_child.setAttribute("gridWidth", "10")
   CALL l_record_child.setAttribute("hidden", "false")
   CALL l_record_child.setAttribute("imageColumn", "")
   CALL l_record_child.setAttribute("justify", "left")
   CALL l_record_child.setAttribute("left", "false")
   CALL l_record_child.setAttribute("lstrAggregatetext", "true")
   CALL l_record_child.setAttribute("lstrcomment", "true")
   CALL l_record_child.setAttribute("lstrtitle", "true")
   CALL l_record_child.setAttribute("name", "ooef001_desc")
   CALL l_record_child.setAttribute("pageSize", "5")
   CALL l_record_child.setAttribute("posX", "23")
   CALL l_record_child.setAttribute("posY", li_gridposy)
   CALL l_record_child.setAttribute("precision", "4")
   CALL l_record_child.setAttribute("precisionDecimal", "16")
   CALL l_record_child.setAttribute("qual1", "YEAR")
   CALL l_record_child.setAttribute("qual2", "YEAR")
   CALL l_record_child.setAttribute("qualFraction", "YEAR")
   CALL l_record_child.setAttribute("repeat", "false")
   CALL l_record_child.setAttribute("reverse", "false")
   CALL l_record_child.setAttribute("rowCount", "1")
   CALL l_record_child.setAttribute("scale", "1") 
   CALL l_record_child.setAttribute("scaleDecimal", "0")
   CALL l_record_child.setAttribute("sizePolicy", "fixed")
   CALL l_record_child.setAttribute("sqlTabName", "")
   CALL l_record_child.setAttribute("sqlType", "CHAR")
   CALL l_record_child.setAttribute("stepX", "1")
   CALL l_record_child.setAttribute("stepY", "0")
   CALL l_record_child.setAttribute("style", "reference")
   CALL l_record_child.setAttribute("repeat", "false") 
   CALL l_record_child.setAttribute("table_alias_name", "")
   CALL l_record_child.setAttribute("tag", "")
   CALL l_record_child.setAttribute("title", "lbl_ooefl003")
   CALL l_record_child.setAttribute("underline", "false")
   CALL l_record_child.setAttribute("unhidable", "false")
   CALL l_record_child.setAttribute("unmovable", "false")
   CALL l_record_child.setAttribute("unsizable", "false")
   CALL l_record_child.setAttribute("unsortable", "false")
   CALL l_record_child.setAttribute("widget", "FFLabel")
         
         
    #回填總使用Y軸長度
    LET li_gridposy = li_gridposy + 1
    CALL l_recordfield.setAttribute("gridHeight",li_gridposy)
    #插入在vbox3 第一個Child 之前
    CALL l_record.insertBefore(l_recordfield, l_other)
    RETURN li_gridposy
END FUNCTION  

#+ 在vbox1 下建立 子Grid 名稱是scrgxx開頭  
#+ 在Grid  下建立 子Image 子Button  子Group 
#+ 在Group 下建立 子元件
PRIVATE FUNCTION adzp154_process_4fd_vbox1(l_record,li_seq,ls_grid,li_gridposy,li_chk)
   DEFINE li_chk        LIKE type_t.num5
   DEFINE l_record      om.DomNode
   DEFINE li_seq        LIKE type_t.num5
   DEFINE ls_grid       STRING 
   DEFINE li_gridheight LIKE type_t.num5 
   DEFINE lc_gzsx002    LIKE gzsx_t.gzsx002
   DEFINE li_gridposy   LIKE type_t.num5   #Grid控件內部的Y軸高度
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE li_page       LIKE type_t.num5
   DEFINE l_recordfield om.DomNode  
   DEFINE l_child       om.DomNode
   DEFINE ls_name       STRING 
   DEFINE li_item       LIKE type_t.num5 
   
   LET li_page = 0
   #換頁的Grid段處理
   FOR li_cnt = 1 TO g_gzsx.getLength()
       IF g_gzsx[li_cnt].gzsx002 <> ls_grid THEN
          #先處理頁尾
          IF li_cnt <> 1 THEN
             #在Grid裡 建立Label child
             #處理頁尾
             CALL adzp154_process_data_item_page_end(l_recordfield,li_gridposy,li_page) RETURNING li_gridposy  

             #回填總使用Y軸長度
             LET li_gridposy = li_gridposy + 1
             LET g_height = g_height + li_gridposy
             #gridHeight 是 scrgr gridHeight
             CALL l_recordfield.setAttribute("gridHeight",li_gridposy)
          END IF

         #換頁後,需要初始化的項目
         LET ls_grid = g_gzsx[li_cnt].gzsx002
         LET li_gridposy = 0    #Grid內高度重新設定

         #在vbox1裡建立Grid child 
         LET li_page = li_page + 1
         LET l_recordfield = l_record.createChild("Grid")
         LET ls_name = "scrgr",li_page USING "<<<<"
         CALL l_recordfield.setAttribute("gridWidth","51")
         CALL l_recordfield.setAttribute("hidden","false")
         CALL l_recordfield.setAttribute("name",ls_name)
         CALL l_recordfield.setAttribute("posX","0")
         CALL l_recordfield.setAttribute("posY","6")
         CALL l_recordfield.setAttribute("style","parameterbox")
         LET li_item = 0
         
       END IF

       #每個子項元件建置處理
       LET l_child = l_recordfield.createChild("Image")
       LET li_item = li_item + 1
       LET ls_name = "image_paramsubgp",li_page USING "<<<<","_",li_item USING "<<<<"
       LET li_gridposy = li_gridposy + 1
       CALL l_child.setAttribute("autoScale","true")
       CALL l_child.setAttribute("gridHeight","1")
       CALL l_child.setAttribute("gridWidth","2")
       CALL l_child.setAttribute("height","16")
       CALL l_child.setAttribute("image","16/s_subgroup.png")
       CALL l_child.setAttribute("name",ls_name)
       CALL l_child.setAttribute("posX","1")
       CALL l_child.setAttribute("posY",li_gridposy)
       CALL l_child.setAttribute("style","noBorder")
       CALL l_child.setAttribute("unitHeight","pixels")
       CALL l_child.setAttribute("unitWidth","pixels")
       CALL l_child.setAttribute("width","16")

       LET l_child = l_recordfield.createChild("Button")
       LET ls_name = "paramsubgp",li_page USING "<<<<","_",li_item USING "<<<<"
       CALL l_child.setAttribute("gridHeight","1")
       CALL l_child.setAttribute("gridWidth","46")
       CALL l_child.setAttribute("name","btn_"||ls_name)
       CALL l_child.setAttribute("posX","4")
       CALL l_child.setAttribute("posY",li_gridposy)
       CALL l_child.setAttribute("style","btnlinktype")
       CALL l_child.setAttribute("tabIndex","")
       CALL l_child.setAttribute("text","lyr_"||ls_name)

       LET l_child = l_recordfield.createChild("Group")
       LET ls_name = "paramsubgp",li_page USING "<<<<","_",li_item USING "<<<<"
       LET li_gridposy = li_gridposy + 1
       CALL l_child.setAttribute("gridWidth","46")
       CALL l_child.setAttribute("name",ls_name)
       CALL l_child.setAttribute("posX","4")
       CALL l_child.setAttribute("posY",li_gridposy)
       CALL l_child.setAttribute("style","parametergroup")

       #建立Group下的子元件 
       CALL adzp154_data_item_group_prepare(l_child,li_cnt,li_seq,li_chk) RETURNING li_seq,li_gridheight,li_chk
       CALL l_child.setAttribute("gridHeight",li_gridheight+2)
       #把posy空間預留出來
       LET li_gridposy = li_gridposy + li_gridheight+2
   END FOR  

   #最後一項多加處理頁尾
   CALL adzp154_process_data_item_page_end(l_recordfield,li_gridposy,li_page) RETURNING li_gridposy
   
   #回填總使用Y軸長度
   LET li_gridposy = li_gridposy + 1
   LET g_height = g_height + li_gridposy
   CALL l_recordfield.setAttribute("gridHeight",li_gridposy)
END FUNCTION  

#+處理頁尾
PRIVATE FUNCTION adzp154_process_data_item_page_end(l_recordfield,li_gridposy,li_page)
   DEFINE l_recordfield om.DomNode
   DEFINE l_child om.DomNode
   DEFINE li_gridposy LIKE type_t.num5 
   DEFINE li_page       LIKE type_t.num5
   DEFINE ls_name     STRING 
   
   LET l_child = l_recordfield.createChild("Label")
   LET ls_name = "Label",li_page USING "<<<<"
   LET li_gridposy = li_gridposy + 1
   CALL l_child.setAttribute("gridHeight","1")
   CALL l_child.setAttribute("gridWidth","49")
   CALL l_child.setAttribute("name",ls_name)
   CALL l_child.setAttribute("posX","1")
   CALL l_child.setAttribute("posY",li_gridposy)
   CALL l_child.setAttribute("sizePolicy","fixed")

   RETURN li_gridposy  
END FUNCTION 



PRIVATE FUNCTION adzp154_process_resize_vbox(ln_record)
   DEFINE ln_record     om.NodeList
   DEFINE li_pos        LIKE type_t.num5
   DEFINE l_record      om.DomNode 
   DEFINE l_child           om.DomNode 

   FOR li_pos = 1 TO ln_record.getLength()
      LET l_record = ln_record.item(li_pos)
      IF l_record.getAttribute("name") = "menubox" THEN 
         CALL l_record.setAttribute("gridHeight", g_gridheight)
         LET l_child = l_record.getFirstChild()
         CALL l_child.setAttribute("gridHeight", g_gridheight-5)
      END IF 

      IF l_record.getAttribute("name") = "infobox" THEN 
         CALL l_record.setAttribute("gridHeight", g_gridheight)
         LET l_child = l_record.getFirstChild()
         CALL l_child.setAttribute("gridHeight", g_gridheight-5)
      END IF 
   END FOR    
END FUNCTION 


#+重新排列容器
PRIVATE FUNCTION adzp154_container_resize(p_node)
   DEFINE p_node            om.DomNode            #table的節點domNode
   DEFINE l_height_source   LIKE type_t.num10     #容器原始大小

   LET p_node = p_node.getParent() #父節點
   LET l_height_source = 0

   #ManagedForm:表示已達到XML Document頂端
   IF p_node.getTagName() = "ManagedForm" THEN
      RETURN
   END IF
      
   IF (NOT cl_null(p_node.getAttribute("gridHeight"))) THEN
      LET l_height_source = p_node.getAttribute("gridHeight")
      LET g_height = g_height + 5
      CALL p_node.setAttribute("gridHeight", g_height)
      IF p_node.getTagName() = "VBox" AND p_node.getAttribute("name") = "vbox3" THEN 
          LET g_gridheight = g_height
      END IF 
   END IF
   CALL adzp154_container_resize(p_node)
END FUNCTION

