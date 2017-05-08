#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ code_id......: adzp154.4gl
#+ descriptions.: 程式資料建立
#+ code_creator.: hjwang

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
MAIN
   DEFINE ls_sql  STRING
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE li_total LIKE type_t.num5
   DEFINE lc_gzsz001 LIKE gzsz_t.gzsz001
   DEFINE ls_code_filename STRING 

   #adz 模組使用 其他模組 使用cl_ap_init()
   CALL cl_tool_init()

   #取得目前的環境代碼
   LET ms_module = ARG_VAL(1) CLIPPED  #模組編號
   LET ms_prog   = ARG_VAL(2) CLIPPED  #程式編號

   #取出作業的頁次架構
   LET ls_sql = "SELECT gzsx002,gzsx004,gzsx003,gzsx005,gzsx006 FROM gzsx_t ",
                " WHERE gzsx001 = '",ms_prog.trim(),"' ",
                " ORDER BY gzsx004,gzsx005 "
   DECLARE adzp154_main_cs CURSOR FROM ls_sql

   #先以分頁 再以分項
   CALL g_gzsx.clear()
   LET li_cnt = 1
   LET lc_gzsz001 = ms_prog
   FOREACH adzp154_main_cs INTO g_gzsx[li_cnt].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      ELSE
         SELECT COUNT(*) INTO li_total FROM gzsz_t
          WHERE gzsz004 = lc_gzsz001
            AND gzsz006 = g_gzsx[li_cnt].gzsx002
            AND gzsz007 = g_gzsx[li_cnt].gzsx003
         #DISPLAY "li_total:",li_total     
         IF li_total = 0 THEN
            CONTINUE FOREACH
         END IF
         LET li_cnt = li_cnt + 1
      END IF
   END FOREACH
   CALL g_gzsx.deleteElement(li_cnt)

   CALL adzp154_read_and_replace() RETURNING ls_code_filename

   #CALL adzp153_comp_4fd(ls_code_filename)
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
   LET ls_sample_filename = os.Path.join(FGL_GETENV("ERP"),"mdl")
   LET ls_sample_filename = os.Path.join(ls_sample_filename,"code_s51.template")
   DISPLAY "azdp154:產生器"

   LET lddoc_all = om.DomDocument.createFromXmlFile(ls_sample_filename)  #om.DomDocument

   #若讀取不到資料代表tabx不存在
   TRY
      LET gdnode_all = lddoc_all.getDocumentElement()                #om.DomNode
   CATCH
      DISPLAY "ERROR:讀取",ls_sample_filename,"發生錯誤, 程式中止!"
      EXIT PROGRAM
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
      EXIT PROGRAM
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

END FUNCTION


#+ 取出資料
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
   DEFINE li_chk      LIKE type_t.num5
      
   #取出om.NodeList 有關tag list
   LET ln_record = gdnode_all.selectByTagName("Record")

   LET li_chk = FALSE 
   IF ms_prog = "aoos020" THEN 
      LET li_chk = TRUE 
   END IF    
   #處理Record
   FOR li_pos = 1 TO ln_record.getLength()
      LET l_record = ln_record.item(li_pos)
      IF l_record.getAttribute("name") = "Undefined" THEN
         LET li_seq = 3 #前2個已被使用 #helptitle、helpdesc  aoos020 第三個 Button edit 第四個 FFLABL 其他 從第五個開始
         FOR li_cnt = 1 TO g_gzsx.getLength()
            CALL adzp154_gen_recordfield(l_record,li_cnt,li_seq,li_chk) RETURNING li_seq,li_chk
         END FOR
      END IF
   END FOR

   #取出om.NodeList 有關tag list
   LET ln_record = gdnode_all.selectByTagName("Grid")

   #處理Record
   FOR li_pos = 1 TO ln_record.getLength()
      LET l_record = ln_record.item(li_pos)
      IF l_record.getAttribute("name") = "Grid1" THEN
         #LET li_seq = 3 #前2個已被使用
         LET li_posy = 1
         LET ls_grid = " "
         #分頁處理 (濾除分項)
         FOR li_cnt = 1 TO g_gzsx.getLength()
            #取換頁時才進行作出Button的動作
            IF g_gzsx[li_cnt].gzsx002 <> ls_grid THEN
               #DISPLAY "g_gzsx[li_cnt].gzsx002:",g_gzsx[li_cnt].gzsx002
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
         CALL l_recordfield.setAttribute("posX","3")    #因 button posX:3 所以 Label 從 posX:3 開始
         CALL l_recordfield.setAttribute("posY",li_posy)
         CALL l_recordfield.setAttribute("text","")

      END IF
   END FOR

   #取出om.NodeList 有關tag list
   LET ln_record = gdnode_all.selectByTagName("VBox")

   LET li_chk = TRUE 
   #處理Grid
   LET li_seq = 3 #前2個已被使用
   

   FOR li_pos = 1 TO ln_record.getLength()
      LET l_record = ln_record.item(li_pos)

      #13/12/13
      #針對azzs020 特別處理
      IF l_record.getAttribute("name") = "vbox3" AND ms_prog = "aoos020"  THEN 
         #取得vbox3 第一個Child
         LET l_other = l_record.getFirstChild() 
         #建一個Grid  
         LET l_recordfield = l_record.createChild("Grid")
         
         LET ls_name = "grid_aoos020",li_page USING "<<<"
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
         LET ls_name = "Label",li_page USING "<<<","grid"

         CALL l_record_child.setAttribute("gridHeight","1")
         CALL l_record_child.setAttribute("gridWidth","10")
         CALL l_record_child.setAttribute("name",ls_name)
         CALL l_record_child.setAttribute("posX","1")
         CALL l_record_child.setAttribute("posY",li_gridposy)
         CALL l_record_child.setAttribute("sizePolicy","fixed")
         CALL l_record_child.setAttribute("text","lbl_site")
         
         #在Grid 下 Child建立 ButtonEdit
         LET ls_image = "16/zoom.png"
         LET l_record_child = l_recordfield.createChild("ButtonEdit")
         CALL l_record_child.setAttribute("gridHeight","1")
         CALL l_record_child.setAttribute("gridWidth","10") 
         CALL l_record_child.setAttribute("action", "controlp")
         CALL l_record_child.setAttribute("colName", "ooea001")
         CALL l_record_child.setAttribute("columnCount", "")
         CALL l_record_child.setAttribute("comment", "columnCount")
         CALL l_record_child.setAttribute("fieldType", "NON_DATABASE")
         CALL l_record_child.setAttribute("sqlTabName", "")
         CALL l_record_child.setAttribute("name", "ooea001")
         CALL l_record_child.setAttribute("lstrtext","true")
         CALL l_record_child.setAttribute("lstrcomment","true")
         CALL l_record_child.setAttribute("image",ls_image)
         CALL l_record_child.setAttribute("comment","")
         CALL l_record_child.setAttribute("hidden","false")
         CALL l_record_child.setAttribute("fontPitch","variable")
         CALL l_record_child.setAttribute("posX","12")
         CALL l_record_child.setAttribute("posY",li_gridposy)
         CALL l_record_child.setAttribute("style","")
         CALL l_record_child.setAttribute("fieldId","3")
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
         CALL l_record_child.setAttribute("fieldId", "4")
         CALL l_record_child.setAttribute("fieldType", "NON_DATABASE")
         CALL l_record_child.setAttribute("fontPitch", "")
         CALL l_record_child.setAttribute("gridHeight", "1")
         CALL l_record_child.setAttribute("gridWidth", "10")
         CALL l_record_child.setAttribute("hidden", "false")
         CALL l_record_child.setAttribute("imageColumn", "")
         CALL l_record_child.setAttribute("justify", "left")
         CALL l_record_child.setAttribute("left", "false")
         CALL l_record_child.setAttribute("lstrAggregatetext", "true")
         CALL l_record_child.setAttribute("lstrcomment", "true")
         CALL l_record_child.setAttribute("lstrtitle", "true")
         CALL l_record_child.setAttribute("name", "ooea001_desc")
         CALL l_record_child.setAttribute("pageSize", "5")
         CALL l_record_child.setAttribute("posX", "23")
         CALL l_record_child.setAttribute("posY", "1")
         CALL l_record_child.setAttribute("precision", "")
         CALL l_record_child.setAttribute("precisionDecimal", "")
         CALL l_record_child.setAttribute("qual1", "YEAR")
         CALL l_record_child.setAttribute("qual2", "YEAR")
         CALL l_record_child.setAttribute("qualFraction", "YEAR")
         CALL l_record_child.setAttribute("repeat", "false")
         CALL l_record_child.setAttribute("reverse", "false")
         CALL l_record_child.setAttribute("rowCount", "1")
         CALL l_record_child.setAttribute("scale", "3") 
         CALL l_record_child.setAttribute("scaleDecimal", "-1")
         CALL l_record_child.setAttribute("sizePolicy", "fixed")
         CALL l_record_child.setAttribute("sqlTabName", "")
         CALL l_record_child.setAttribute("sqlType", "CHAR")
         CALL l_record_child.setAttribute("stepX", "1")
         CALL l_record_child.setAttribute("stepY", "0")
         CALL l_record_child.setAttribute("style", "reference")
         CALL l_record_child.setAttribute("repeat", "false") 
         CALL l_record_child.setAttribute("table_alias_name", "")
         CALL l_record_child.setAttribute("tag", "")
         CALL l_record_child.setAttribute("title", "lbl_ooealoo3")
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
      END IF 
      #13/12/13

      
      IF l_record.getAttribute("name") = "vbox1" THEN
         LET ls_grid = " "
         LET li_page = 0
         LET li_gridend = FALSE
         IF ms_prog = "aoos020" THEN 
            LET li_seq = 4 
         END IF 
         FOR li_cnt = 1 TO g_gzsx.getLength()
          
            #換頁的Grid段處理
            IF g_gzsx[li_cnt].gzsx002 <> ls_grid THEN
               #先處理頁尾
               IF li_cnt <> 1 THEN
                  LET l_child = l_recordfield.createChild("Label")
                  LET ls_name = "Label",li_page USING "<<<"
                  LET li_gridposy = li_gridposy + 1
                  CALL l_child.setAttribute("gridHeight","1")
                  CALL l_child.setAttribute("gridWidth","49")
                  CALL l_child.setAttribute("name",ls_name)
                  CALL l_child.setAttribute("posX","1")
                  CALL l_child.setAttribute("posY",li_gridposy)
                  CALL l_child.setAttribute("sizePolicy","fixed")

                  #回填總使用Y軸長度
                  LET li_gridposy = li_gridposy + 1
                  CALL l_recordfield.setAttribute("gridHeight",li_gridposy)
               END IF

               #換頁後,需要初始化的項目
               LET ls_grid = g_gzsx[li_cnt].gzsx002
               LET li_gridposy = 0    #Grid內高度重新設定

               LET li_page = li_page + 1
               LET l_recordfield = l_record.createChild("Grid")
               LET ls_name = "scrgr",li_page USING "<<<"
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
               LET ls_name = "image_paramsubgp",li_page USING "<<<","_",li_item USING "<<<"
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
               LET ls_name = "paramsubgp",li_page USING "<<<","_",li_item USING "<<<"
               CALL l_child.setAttribute("gridHeight","1")
               CALL l_child.setAttribute("gridWidth","46")
               CALL l_child.setAttribute("name","btn_"||ls_name)
               CALL l_child.setAttribute("posX","4")
               CALL l_child.setAttribute("posY",li_gridposy)
               CALL l_child.setAttribute("style","btnlinktype")
               CALL l_child.setAttribute("tabIndex","")
               CALL l_child.setAttribute("text","lyr_"||ls_name)

            LET l_child = l_recordfield.createChild("Group")
               LET ls_name = "paramsubgp",li_page USING "<<<","_",li_item USING "<<<"
               LET li_gridposy = li_gridposy + 1
               CALL l_child.setAttribute("gridWidth","46")
               CALL l_child.setAttribute("name",ls_name)
               CALL l_child.setAttribute("posX","4")
               CALL l_child.setAttribute("posY",li_gridposy)
               CALL l_child.setAttribute("style","parametergroup")
               CALL adzp154_gen_group(l_child,li_cnt,li_seq,li_chk) RETURNING li_seq,li_gridheight,li_chk
               CALL l_child.setAttribute("gridHeight",li_gridheight+2)
               #把posy空間預留出來
               LET li_gridposy = li_gridposy + li_gridheight+2

         END FOR

         #最後一項多加處理頁尾
            LET l_child = l_recordfield.createChild("Label")
            LET ls_name = "Label",li_page USING "<<<"
            LET li_gridposy = li_gridposy + 1
            CALL l_child.setAttribute("gridHeight","1")
            CALL l_child.setAttribute("gridWidth","49")
            CALL l_child.setAttribute("name",ls_name)
            CALL l_child.setAttribute("posX","1")
            CALL l_child.setAttribute("posY",li_gridposy)
            CALL l_child.setAttribute("sizePolicy","fixed")

            #回填總使用Y軸長度
            LET li_gridposy = li_gridposy + 1
            CALL l_recordfield.setAttribute("gridHeight",li_gridposy)

      END IF
   END FOR

END FUNCTION

#+ 產生變數Record內相關資料,全部產生再Undefine群組內
PRIVATE FUNCTION adzp154_gen_recordfield(l_record,li_cnt,li_seq,li_chk)
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
   
   LET ls_sql = "SELECT gzsz002,gzsz003 FROM gzsz_t ",
                " WHERE gzsz004 = '",ms_prog.trim(),"' ",     #作業編號
                  " AND gzsz006 = '",g_gzsx[li_cnt].gzsx002 CLIPPED,"' ", #分頁
                  " AND gzsz007 = '",g_gzsx[li_cnt].gzsx003 CLIPPED,"' ", #分項
                  " AND gzszstus = 'Y' ",                     #有效碼
                " ORDER BY gzsz005 "                          #排序
   DECLARE adzp154_gen_recordfield_cs CURSOR FROM ls_sql
   LET li_pos = 1

   IF ms_prog = "aoos020" AND li_chk THEN 
      LET l_recordfield = l_record.createChild("RecordField")
      CALL l_recordfield.setAttribute("colName","ooea001")
      CALL l_recordfield.setAttribute("fieldIdRef",li_seq)
      CALL l_recordfield.setAttribute("fieldType","NON_DATABASE")
      CALL l_recordfield.setAttribute("name","ooea001")
      CALL l_recordfield.setAttribute("length","50")
      
      CALL l_recordfield.setAttribute("sqlTabName","")
      CALL l_recordfield.setAttribute("sqlType","CHAR")
      CALL l_recordfield.setAttribute("table_alias_name","")       
      LET li_chk = FALSE 
      #第四個給 FFLABEL 其他從第五個開始
      LET li_seq = li_seq + 1
      LET l_recordfield = l_record.createChild("RecordField")
      CALL l_recordfield.setAttribute("colName","")
      CALL l_recordfield.setAttribute("defaultValue","")
      CALL l_recordfield.setAttribute("fieldIdRef",li_seq)
      CALL l_recordfield.setAttribute("fieldType","NON_DATABASE")
      CALL l_recordfield.setAttribute("name","gzsz001_desc")
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

   FOREACH adzp154_gen_recordfield_cs INTO lc_gzsz002,lc_gzsz003
      LET l_recordfield = l_record.createChild("RecordField")
      CALL l_recordfield.setAttribute("colName","")
      CALL l_recordfield.setAttribute("fieldIdRef",li_seq)
      CALL l_recordfield.setAttribute("fieldType","NON_DATABASE")
      CALL l_recordfield.setAttribute("length","80")
      LET ls_name = g_gzsx[li_cnt].gzsx002 CLIPPED,
                "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",li_pos USING "<<<"
      CALL l_recordfield.setAttribute("name",ls_name)
      CALL l_recordfield.setAttribute("sqlTabName","")
      CALL l_recordfield.setAttribute("sqlType","VARCHAR")
      CALL l_recordfield.setAttribute("table_alias_name","")
      LET li_seq = li_seq + 1
      LET li_pos = li_pos + 1
   END FOREACH
   RETURN li_seq,li_chk
END FUNCTION

#+ 產生每個分項下方的設定節點
PRIVATE FUNCTION adzp154_gen_group(l_group,li_cnt,li_seq,li_chk)
   DEFINE l_group     om.DomNode
   DEFINE l_child     om.DomNode
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE li_pos      LIKE type_t.num5
   DEFINE lc_gzsz002  LIKE gzsz_t.gzsz002 #參數編號
   DEFINE lc_gzsz003  LIKE gzsz_t.gzsz003 #輸入限制資料型態 
   DEFINE li_seq      LIKE type_t.num5    #產生fieldId序號(須連續)
   DEFINE li_posy     LIKE type_t.num5    #widget起始位置
   DEFINE ls_name     STRING
   DEFINE ls_sql      STRING
   DEFINE li_chk      LIKE type_t.num5

   LET ls_sql = "SELECT gzsz002,gzsz003 FROM gzsz_t ",
                " WHERE gzsz004 = '",ms_prog.trim(),"' ",     #作業編號
                  " AND gzsz006 = '",g_gzsx[li_cnt].gzsx002 CLIPPED,"' ", #分頁
                  " AND gzsz007 = '",g_gzsx[li_cnt].gzsx003 CLIPPED,"' ", #分項
                  " AND gzszstus = 'Y' ",                     #有效碼
                " ORDER BY gzsz005 "                          #排序
   DECLARE adzp154_gen_group_cs CURSOR FROM ls_sql
   LET li_pos = 1
   LET li_posy = 0
   FOREACH adzp154_gen_group_cs INTO lc_gzsz002,lc_gzsz003
      #目前先以 Button 為控件
      LET l_child = l_group.createChild("Button")
      LET ls_name = "help_",g_gzsx[li_cnt].gzsx002 CLIPPED,
                        "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",li_pos USING "<<<"
     #LET ls_name = "help_",lc_gzsz002 CLIPPED
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
                       "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",li_pos USING "<<<"
         CALL l_child.setAttribute("gridHeight","1")
         CALL l_child.setAttribute("gridWidth","21")
         CALL l_child.setAttribute("name",ls_name)
         CALL l_child.setAttribute("posX","4")
         CALL l_child.setAttribute("posY",li_posy)
         CALL l_child.setAttribute("text",ls_name)
         LET li_posy = li_posy + 1 
      END IF 

      #處理不同的輸入型態
      CASE 
         #Y/N
         WHEN lc_gzsz003 = "1" 
              LET ls_name = "lbl_",g_gzsx[li_cnt].gzsx002 CLIPPED,
                            "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",li_pos USING "<<<"
          
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
         #整數選項  #範圍設定  #字元
         WHEN lc_gzsz003 = "2" OR lc_gzsz003 = "3" OR lc_gzsz003 = "4"
              LET l_child = l_group.createChild("Edit")
              CALL l_child.setAttribute("widget","Edit")
              CALL l_child.setAttribute("comment",lc_gzsz002 CLIPPED)
         #日期
         WHEN lc_gzsz003 = "5" 
              LET l_child = l_group.createChild("DateEdit")      
              CALL l_child.setAttribute("noEntry","false")
              CALL l_child.setAttribute("repeat","false")
              CALL l_child.setAttribute("title","DateEdit1")
              CALL l_child.setAttribute("widget","DateEdit")
              
      END CASE 

      IF ms_prog = "aoos020" AND li_chk THEN
         LET li_seq = li_seq + 1  
         LET li_chk = FALSE  
      END IF

            #LET li_posy = li_posy + 1
            LET ls_name = g_gzsx[li_cnt].gzsx002 CLIPPED,
                      "_",g_gzsx[li_cnt].gzsx003 CLIPPED,"_",li_pos USING "<<<"
            
            CALL l_child.setAttribute("aggregateColName","")
            CALL l_child.setAttribute("aggregateName","")
            CALL l_child.setAttribute("aggregateTableAliasName","")
            CALL l_child.setAttribute("aggregateTableName","")
            CALL l_child.setAttribute("fieldId",li_seq)
            CALL l_child.setAttribute("gridHeight","1")
            CALL l_child.setAttribute("gridWidth","10")
            CALL l_child.setAttribute("name",ls_name)
            CALL l_child.setAttribute("posX","4")
            CALL l_child.setAttribute("posY",li_posy)
            CALL l_child.setAttribute("tabIndex","")
            
      LET li_pos = li_pos + 1
      LET li_seq = li_seq + 1
   END FOREACH
   RETURN li_seq,li_posy,li_chk
END FUNCTION


#+ complier及link及產生多語言 
PRIVATE FUNCTION adzp153_comp_4fd(ps_code_filename) 
   DEFINE ps_code_filename STRING  #/u1/t10dev/erp/aoo/4gl/aoos010.4gl
   DEFINE ls_dir           STRING 
   DEFINE li_result        LIKE type_t.num5
   DEFINE ls_psg           STRING 

   LET ls_dir = os.Path.dirname(ps_code_filename)
   #DISPLAY "4fd ls_dir:",ls_dir
   IF  os.Path.chdir(ls_dir) THEN END IF 
   CALL cl_cmdrun_openpipe("r.f","r.f "||ms_prog ,"0") RETURNING li_result,ls_psg

   
END FUNCTION 
