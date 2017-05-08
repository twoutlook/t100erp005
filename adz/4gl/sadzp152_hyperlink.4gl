#adzp152 副程式 - 串查功能相關處理
# Modify........: No:YSC-E40005 14/04/23 By joyce 單身串查功能網址取得方式，改為呼叫cl_ap_url
# Modify........: No:YSC-E40007 14/04/29 By joyce 調整字串預設值給予的位置
# Modify........: No:YSC-E70003 14/07/24 By joyce 單身串查功能可承接變數

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS
   DEFINE g_properties   om.SaxAttributes
   CONSTANT li_space = 3
# YSC-E30002 ---start---
   DEFINE g_form_field DYNAMIC ARRAY OF RECORD
          type         LIKE type_t.chr10,
          page         LIKE type_t.num5,
          sr_record    LIKE type_t.chr20,
          tot_count    LIKE type_t.num5,
          var_field    LIKE type_t.chr50,
          form_field   LIKE type_t.chr50
          END RECORD
# YSC-E30002 --- end ---
# YSC-E70003 ---start---
   DEFINE g_para_data DYNAMIC ARRAY OF RECORD
          field          LIKE type_t.chr100,   # 欄位
          para_no        LIKE type_t.num5,     # 參數項次
          para_data      LIKE type_t.chr200,   # 參數值
          para_totcount  LIKE type_t.num5      # 參數個數
          END RECORD
# YSC-E70003 --- end ---
END GLOBALS


#+ 取串查欄位資訊
PUBLIC FUNCTION adzp152_get_hyperlink_info(ldnode_parent,p_type,p_page)
   DEFINE ldnode_parent   om.DomNode
   DEFINE p_type          STRING
   DEFINE p_page          STRING                #頁數
   DEFINE li_cnt          LIKE type_t.num10
   DEFINE ldnode_hyper    om.DomNode
   DEFINE ls_str          STRING
   DEFINE ls_str1         STRING
   DEFINE lst_token       base.StringTokenizer   #YSC-E70003
   DEFINE ls_token        LIKE type_t.chr200     #YSC-E70003
   DEFINE ls_field        LIKE type_t.chr100     #YSC-E70003
   DEFINE ls_para_count   LIKE type_t.num5       #YSC-E70003
   DEFINE ls_cnt          LIKE type_t.num5       #YSC-E70003
   DEFINE ls_para         STRING                 #YSC-E70003

   IF p_type = "detail_show" THEN
      FOR li_cnt = 1 TO ldnode_parent.getChildCount()
         LET ldnode_hyper = ldnode_parent.getChildByIndex(li_cnt)
         IF ldnode_hyper.getTagName() = "cluster" THEN
            # 查詢時開啟的欄位
            LET ls_str = "detail_hyper_qry_field_",ldnode_hyper.getAttribute("id")
            LET ls_str1 = adzp152_create_name(p_page, ls_str, "<<<")
            CALL g_properties.addAttribute(ls_str1,ldnode_hyper.getAttribute("qry_field"))

            # 串查的程式代號
            LET ls_str = "detail_hyper_prog_",ldnode_hyper.getAttribute("id")
            LET ls_str1 = adzp152_create_name(p_page, ls_str, "<<<")
            CALL g_properties.addAttribute(ls_str1,ldnode_hyper.getAttribute("prog"))

            # 傳遞的參數
            LET ls_str = "detail_hyper_parameter_",ldnode_hyper.getAttribute("id")
            LET ls_str1 = adzp152_create_name(p_page, ls_str, "<<<")
            CALL g_properties.addAttribute(ls_str1,ldnode_hyper.getAttribute("parameter"))

            # YSC-E70003 ---start---
            # 將各欄位的傳入參數個數寫入暫存檔
            LET ls_field = ldnode_hyper.getAttribute("id")
            LET ls_str = ldnode_hyper.getAttribute("parameter")
            CALL adzp152_parse_hyper_para(ls_field,ls_str)
            # YSC-E70003 --- end ---
         END IF
      END FOR
   END IF
END FUNCTION


#+ 組串查功能的程式段落
PUBLIC FUNCTION adzp152_detail_write_hyperlink()
   DEFINE ls_tmp               STRING
   DEFINE li_page              LIKE type_t.num5
   DEFINE lst_token            base.StringTokenizer
   DEFINE ls_token             STRING
   DEFINE ls_parameter         STRING
   DEFINE ls_parameter_gwc     STRING
   DEFINE ls_hyper_b_fill      STRING
   DEFINE ls_hyper_b_fill_gwc  STRING
   DEFINE ls_field_list        STRING
   DEFINE ls_field_string      STRING
   DEFINE ls_qry_field         STRING
   DEFINE ls_field             LIKE type_t.chr50
   DEFINE li_i                 LIKE type_t.num5
   DEFINE li_str               STRING
   DEFINE li_str1              STRING
   DEFINE l_sql                STRING
   DEFINE ls_var_title         STRING
   DEFINE ls_bef_construct     STRING
   DEFINE ls_aft_construct     STRING
   DEFINE ls_field_count       LIKE type_t.num5
   DEFINE ls_field_count_all   LIKE type_t.num5
   DEFINE ls_no                LIKE type_t.num5   # YSC-E30002
   DEFINE ls_prog              STRING   #YSC-E40005
   DEFINE ls_i                 LIKE type_t.num5   # YSC-E70003


   # 若是有做串查功能，需做以下處理
   # 範例：aaaa001有做串查，在b_fill段要組為
   #       IF FGL_GETENV("GWC") THEN
   #          LET g_aaaa_d[l_ac].prog_b_aaaa001 = "<a herf = ''...>"
   #       ELSE
   #          LET g_aaaa_d[l_ac].prog_b_aaaa001 = "<a href = ''...>"
   #       END IF

   #       在query段要將先將串查顯示欄位(prog_b_aaaa001)隱藏，將查詢用欄位(b_aaaa001)開啟，
   #       離開construct段後，再將串查顯示欄位(prog_b_aaaa001)開啟，將查詢用欄位(b_aaaa001)隱藏
   # 範例：CALL gfrm_curr.setFieldHidden("b_aaaa001",FALSE)
   #       CALL gfrm_curr.setFieldHidden("prog_b_aaaa001",TRUE)
   #       離開Construct後
   #       CALL gfrm_curr.setFieldHidden("b_aaaa001",TRUE)
   #       CALL gfrm_curr.setFieldHidden("prog_b_aaaa001",FALSE)


   # YSC-E30002 ---start---
   LET l_sql = "SELECT * FROM adzp152_form_tmp ",
               " WHERE type = 'body'",   #目前只有單身才有做串查
                 " AND page = ?"
   PREPARE adzp152_hyperlink_pre FROM l_sql
   DECLARE adzp152_hyperlink_curs CURSOR FOR adzp152_hyperlink_pre
   # YSC-E30002 --- end ---

   # YSC-E70003 ---start---
   LET l_sql = "SELECT COUNT(*) FROM adzp152_para_tmp ",
               " WHERE field = ?"
   PREPARE adzp152_para_count_pre FROM l_sql
   # YSC-E70003 --- end ---

   LET li_i = g_properties.getValue("page")
   LET ls_bef_construct = NULL
   LET ls_aft_construct = NULL
   LET ls_field_count_all = 0
   FOR li_page = 1 TO li_i
      LET ls_field_list = NULL
      LET ls_hyper_b_fill = NULL
      LET ls_hyper_b_fill_gwc = NULL
      LET ls_field_count = 0

      # 取有做串查功能的欄位
      # YSC-E30002 ---modify start---
      LET ls_no = 1
      CALL g_form_field.clear()
      FOREACH adzp152_hyperlink_curs USING li_page INTO g_form_field[ls_no].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'Get Hyperlink Field FOREACH:'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF

         LET li_str = g_form_field[ls_no].form_field
         IF li_str.getIndexOf("prog_",1) THEN
            LET ls_parameter = NULL
            LET ls_parameter_gwc = NULL
            LET ls_field_count_all = ls_field_count_all + 1
            LET ls_field_count = ls_field_count + 1

            # YSC-E70003 ---start---
            #紀錄每個頁籤串查欄位的起始個數
            IF ls_field_count = 1 THEN
               LET li_str = "detail_hyper_field_no_b_",li_page USING "<<<"
               CALL g_properties.addAttribute(li_str,ls_field_count_all)
            END IF
            # YSC-E70003 --- end ---

            # 取得陣列名稱
            IF li_page = 1 THEN
               LET ls_var_title = g_properties.getValue("detail_var_title")
            ELSE
               LET li_str = "detail_var_title",li_page USING "<<<"
               LET ls_var_title = g_properties.getValue(li_str)
            END IF

            # 組合b_fill段會用到的變數
            # 若最後組合出來的程式段應為
            #                 A                                   B                             C
            #     _____________________________   ___________________________________  ______________________
            # LET g_gzwa_d[l_ac].prog_b_gzwa001 = "<a href ='http://10.40.40.18/...'>",g_gzwa_d[l_ac].gzwa001,"</a>"

            # 組合A變數
            LET ls_tmp = ls_var_title,"[l_ac].",g_form_field[ls_no].var_field
         #  LET li_str = "detail_hyper_b_fill_url_field",ls_field_count USING "<<<"   #YSC-E70003 mark
            LET li_str = "detail_hyper_b_fill_url_field",ls_field_count_all USING "<<<"   #YSC-E70003 modify
            CALL g_properties.addAttribute(li_str,ls_tmp)

            # 組合C變數
            LET li_str = adzp152_create_name(li_page, "detail_hyper_qry_field_"||g_form_field[ls_no].var_field, "<<<")
            LET ls_qry_field = g_properties.getValue(li_str)
            #註：因為欄位定義時是有截掉 "_" 的，所以在組合程式碼時，若是有用到定義的變數也須把 "_" 截掉  150428
            IF ls_qry_field.getIndexOf("_",1)         AND
               NOT ls_qry_field.getIndexOf("_desc",1) AND
               NOT ls_qry_field.getIndexOf("prog_",1) AND    #YSC-E30002 add
               NOT ls_qry_field.getIndexOf("l_",1)    AND
               NOT ls_qry_field.getIndexOf("lc_",1)   THEN

               LET ls_tmp = ls_var_title,"[l_ac].",ls_qry_field.subString(1, ls_qry_field.getIndexOf("_",1)-1)
            ELSE
               LET ls_tmp = ls_var_title,"[l_ac].",ls_qry_field
            END IF
         #  LET li_str = "detail_hyper_b_fill_field",ls_field_count USING "<<<"   #YSC-E70003 mark
            LET li_str = "detail_hyper_b_fill_field",ls_field_count_all USING "<<<"   #YSC-E70003 modify
            CALL g_properties.addAttribute(li_str,ls_tmp)

            # YSC-E40005 ---mark start---
         #  # 組合B變數
         #  # B變數(非GWC時)
         #  LET li_str = adzp152_create_name(li_page, "detail_hyper_parameter_"||g_form_field[ls_no].var_field, "<<<")
         #  LET ls_parameter = g_properties.getValue(li_str)
         #  IF NOT cl_null(ls_parameter) THEN
         #     LET ls_tmp = "\"<a href = '\",g_hyper_url,\"/\",",ls_parameter,"'>\""
         #  ELSE
         #     LET ls_tmp = "\"<a href = '\",g_hyper_url,\"'>\""
         #  END IF
         #  LET li_str = "detail_hyper_b_fill_hyperlink",ls_field_count USING "<<<"
         #  CALL g_properties.addAttribute(li_str,ls_tmp)

         #  # B變數(是GWC時)
         #  LET li_str = adzp152_create_name(li_page, "detail_hyper_parameter_gwc_"||g_form_field[ls_no].var_field, "<<<")
         #  LET ls_parameter_gwc = g_properties.getValue(li_str)
         #  IF NOT cl_null(ls_parameter_gwc) THEN
         #     LET ls_tmp = "\"<a href = '\",g_hyper_url,\"/\",",ls_parameter_gwc,"'>\""
         #  ELSE
         #     LET ls_tmp = "\"<a href = '\",g_hyper_url,\"'>\""
         #  END IF
         #  LET li_str = "detail_hyper_b_fill_hyperlink_gwc",ls_field_count USING "<<<"
         #  CALL g_properties.addAttribute(li_str,ls_tmp)
            # YSC-E40005 --- mark end ---

            # YSC-E40005 ---start---
            # 單身串查改為呼叫lib的方式
            # 取出要串查的程式代號
            LET li_str = adzp152_create_name(li_page, "detail_hyper_prog_"||g_form_field[ls_no].var_field, "<<<")
            LET ls_prog = g_properties.getValue(li_str)
            LET li_str = "detail_hyper_prog",ls_field_count_all USING "<<<"
            CALL g_properties.addAttribute(li_str,ls_prog)

            # 有做串查的欄位名稱
            LET ls_tmp = g_form_field[ls_no].var_field
            LET li_str = "detail_hyper_field",ls_field_count_all USING "<<<"
            CALL g_properties.addAttribute(li_str,ls_tmp)

            # 取出要傳到串查程式的參數
            LET li_str = adzp152_create_name(li_page, "detail_hyper_parameter_"||g_form_field[ls_no].var_field, "<<<")
            LET ls_parameter = g_properties.getValue(li_str)
            # YSC-E40005 --- end ---
            # YSC-E70003 ---start---
            LET ls_field = g_form_field[ls_no].var_field
            EXECUTE adzp152_para_count_pre USING ls_field INTO ls_i
            IF ls_i > 0 THEN
               LET ls_tmp = adzp152_get_para_data(ls_field,ls_field_count_all)
               LET li_str = "detail_hyper_field_para",ls_field_count_all USING "<<<"
               CALL g_properties.addAttribute(li_str,ls_tmp)
            END IF
            # YSC-E70003 --- end ---

            # 組欄位隱藏與顯示的程式段
            # 1.顯示欄位在CONSTRUCT前，需先隱藏，在CONSTRUCT後再開啟
            # 2.查詢欄位在CONSTRUCT前，需先開啟，在CONSTRUCT後再隱藏
            LET li_str = "detail_hyper_bef_form_field_true",ls_field_count_all USING "<<<"
            CALL g_properties.addAttribute(li_str, g_form_field[ls_no].form_field)
            LET li_str = "detail_hyper_aft_form_field_false",ls_field_count_all USING "<<<"
            CALL g_properties.addAttribute(li_str, g_form_field[ls_no].form_field)

            LET l_sql = "SELECT form_field FROM adzp152_form_tmp",
                        " WHERE type = 'body'",    # 目前串查功能僅限單身
                          " AND page = ",li_page,
                          " AND var_field = '",ls_qry_field,"'"
            PREPARE adzp152_hyper_cur2 FROM l_sql
            EXECUTE adzp152_hyper_cur2 INTO ls_field
            LET li_str = "detail_hyper_bef_form_field_false",ls_field_count_all USING "<<<"
            CALL g_properties.addAttribute(li_str,ls_field)
            LET li_str = "detail_hyper_aft_form_field_true",ls_field_count_all USING "<<<"
            CALL g_properties.addAttribute(li_str,ls_field)

            # 紀錄所有有做串查功能的欄位
            LET ls_field_list = ls_field_list, g_form_field[ls_no].var_field, ","
         END IF

         LET ls_no = ls_no + 1
      END FOREACH
      CALL g_form_field.deleteElement(ls_no)
      # YSC-E30003 --- modify end ---

      LET ls_field_list = ls_field_list.subString(1, ls_field_list.getLength()-1)

      LET li_str = adzp152_create_name(li_page, "detail_hyper_fields_all", "<<<")   # YSC-E40005 modify detail_hyper_fields -> detail_hyper_fields_all
      CALL g_properties.addAttribute(li_str,ls_field_list) 

      LET li_str = adzp152_create_name(li_page, "hyper_field_count", "<<<")
      CALL g_properties.addAttribute(li_str,ls_field_count) 

      # 若此page有做串查功能，才需要將相關資料寫入
      IF ls_field_count > 0 THEN
         # YSC-E70003 ---start---
         #紀錄每個頁籤串查欄位的結束個數
         LET li_str = "detail_hyper_field_no_e_",li_page USING "<<<"
         CALL g_properties.addAttribute(li_str,ls_field_count_all)
         # YSC-E70003 --- end ---

         LET li_str = adzp152_create_name(li_page, "detail_hyper_b_fill", "<<<")
         CALL g_properties.addAttribute(li_str,adzp152_read_hyper_slice("qs24",li_page))  #YSC-E40005 modify qs01 -> qs24

         # YSC-E40005 ---mark start---
      #  IF cl_null(g_properties.getValue("general_hyperlink_url")) THEN
      #     LET ls_tmp = "\#取串查網址\n",
      #                  (li_space*1) SPACES,"LET g_hyper_url = cl_get_para('','','A-SYS-0021')\n",
      #                  (li_space*1) SPACES,"IF g_hyper_url.subString(g_hyper_url.getLength(),g_hyper_url.getLength()) = '/' THEN\n",
      #                  (li_space*2) SPACES,"LET g_hyper_url = g_hyper_url.subString(1,g_hyper_url.getLength()-1)\n",
      #                  (li_space*1) SPACES,"END IF"
      #     CALL g_properties.addAttribute("general_hyperlink_url",ls_tmp)
      #  END IF
         # YSC-E40005 --- mark end ---
      END IF
   END FOR

   # 紀錄全部的頁籤中，有多少欄位有做串查功能
   CALL g_properties.addAttribute("hyper_field_count_all",ls_field_count_all)

   # 讀取子樣板組相關資訊
   IF ls_field_count_all > 0 THEN
      LET li_str = "general_hyperlink_func"   #YSC-E40005 add
      CALL g_properties.addAttribute(li_str,adzp152_read_hyper_slice("qs01",li_page))   #YSC-E40005 add
      LET li_str = "detail_hyper_bef_construct"
      CALL g_properties.addAttribute(li_str,adzp152_read_hyper_slice("qs02",li_page))
      LET li_str = "detail_hyper_aft_construct"
      CALL g_properties.addAttribute(li_str,adzp152_read_hyper_slice("qs03",li_page))
   END IF

END FUNCTION


#+讀取子樣板資料
PUBLIC FUNCTION adzp152_read_hyper_slice(ps_slice,ps_page)
   DEFINE ps_slice        STRING
   DEFINE ps_page         LIKE type_t.num5
   DEFINE ls_slice        STRING
   DEFINE ls_str          STRING
   DEFINE ls_mdl          STRING
   DEFINE ls_read         STRING
   DEFINE ls_return       STRING
   DEFINE ls_text         STRING
   DEFINE ls_cha_read     base.Channel
   DEFINE li_mdls         LIKE type_t.num5   #YSC-E70003
   DEFINE ls_mdlpath      STRING

   #YSC-E70003 ---mark start---
#  CASE
#     WHEN ps_slice = "qs24"   # YSC-E40005 modify
#        LET ls_str = adzp152_create_name(ps_page,"hyper_field_count", "<<<")
#        LET li_num = g_properties.getValue(ls_str)
#     WHEN ps_slice = "qs01" OR ps_slice = "qs02" OR ps_slice = "qs03"   #YSC-E40005 modify
#        LET li_num = g_properties.getValue("hyper_field_count_all")
#  END CASE
#  IF cl_null(ps_slice) OR li_num < 1 THEN
   #YSC-E70003 --- mark end ---

   IF cl_null(ps_slice) THEN
      RETURN ""
   END IF

   #先讀取T100TEMPLATEPATH, 若無則採用$ERP/mdl
   LET ls_mdlpath = FGL_GETENV("T100TEMPLATEPATH")
   IF cl_null(ls_mdlpath) THEN
      LET ls_mdlpath = FGL_GETENV("ERP")
      LET ls_mdlpath = os.Path.join(ls_mdlpath,"mdl")
   END IF

   #定義取用樣板檔案
   LET ls_slice = "slice/code_",ps_slice,".template"
#  LET ls_slice = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"mdl"),ls_slice)
   LET ls_slice = os.Path.join(ls_mdlpath,ls_slice)

   #開啟樣板檔
   LET ls_cha_read = base.Channel.create()
   CALL ls_cha_read.setDelimiter("")

   CALL ls_cha_read.openFile( ls_slice CLIPPED, "r" )

   WHILE NOT ls_cha_read.isEof()

      LET ls_text = ""
      LET ls_read = ls_cha_read.readLine()

      #產生code部分
      IF ls_read.getIndexOf("#hyperlink - Start -",1) > 0 THEN
         CALL adzp152_get_other_hyper_data(ps_slice,ls_cha_read,ps_page) RETURNING ls_cha_read,ls_read   #YSC-E70003 add ps_page delete li_num
      END IF

      #行代換/ 對 ${} 置換
      IF ls_read.getIndexOf("${",1) AND
         ( ls_read.getIndexOf("${",1) < ls_read.getIndexOf("}",1) ) THEN
         LET ls_text = adzp152_line_replace(ls_read)
      ELSE
         LET ls_text = ls_read
      END IF
      LET ls_return = ls_return, ls_text, " \n"
   END WHILE

   CALL ls_cha_read.close()

   RETURN ls_return
END FUNCTION


#+ 依據資料數量，將串查功能設定的資料產生到對應段落
PUBLIC FUNCTION adzp152_get_other_hyper_data(l_slice,l_read,l_page)
   DEFINE l_slice         STRING
   DEFINE l_read          base.Channel
   DEFINE l_page          LIKE type_t.num5    #YSC-E70003
   DEFINE l_tmp           STRING
   DEFINE l_hyper         DYNAMIC ARRAY OF STRING
   DEFINE li_cnt          LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_type          LIKE type_t.chr1    # 樣板中要取代的變數是否為多層架構
   DEFINE l_str           STRING
   DEFINE l_word          STRING
   DEFINE l_start_no      LIKE type_t.num5    #YSC-E70003
   DEFINE l_end_no        LIKE type_t.num5    #YSC-E70003


   IF l_slice = "qs01" OR l_slice = "qs02" OR l_slice = "qs03" OR l_slice = "qs24" THEN   #YSC-E40005 add qs24
      LET l_type = "Y"
   ELSE
      LET l_type = "N"
   END IF

   #先取出hyperlink段落之樣本
   WHILE TRUE
      LET l_tmp = l_read.readLine()
      CASE
         WHEN l_tmp.getIndexOf("#hyperlink -  End  -",1)
            EXIT WHILE
      END CASE
      LET l_hyper[1] = l_hyper[1],l_tmp , "\n"
   END WHILE

#  LET l_str = l_hyper[1]   #YSC-E40007 mark
   LET ls_return = ""

   #根據有做串查功能的欄位數量產生對應的段落並進行資料取代
   # YSC-E70003 ---modify start---
   CASE
      WHEN l_slice = "qs24"
         LET l_str = "detail_hyper_field_no_b_",l_page USING "<<<"
         LET l_start_no = g_properties.getValue(l_str)
         LET l_str = "detail_hyper_field_no_e_",l_page USING "<<<"
         LET l_end_no = g_properties.getValue(l_str)

      OTHERWISE
         LET l_start_no = 2
         LET l_end_no = g_properties.getValue("hyper_field_count_all")
   END CASE

   FOR li_cnt = l_start_no TO l_end_no
      LET l_str = l_hyper[1]   #YSC-E40007 add
  
      # 若是多層架構，先取代第二層，再取代第一層
      # EX: ${hyper_data${page}}  ->  ${hyper_data2}  ->  "http://10.40.40.18/..."
      IF l_type = "Y" THEN
         LET l_word = "${hyper_field_count_all}"
  
         # 若有符合需重複取代
         WHILE l_str.getIndexOf(l_word, 1) > 0
            LET l_str = cl_replace_str(l_str, l_word, li_cnt)
         END WHILE
      END IF
      LET ls_return = ls_return, l_str
  
      WHILE ls_return.getIndexOf("${",1) > 0
         LET ls_return = adzp152_line_replace(ls_return)
      END WHILE
   END FOR
   # YSC-E70003 --- modify end ---

   RETURN l_read, ls_return

END FUNCTION

# YSC-E70003 ---start---
#+ 將串查功能的傳入參數依序組合
PUBLIC FUNCTION adzp152_get_para_data(lc_field,lc_item_no)
   DEFINE lc_field        LIKE type_t.chr100
   DEFINE lc_item_no      LIKE type_t.num5    #第幾個有做串查的欄位
   DEFINE ls_slice        STRING
   DEFINE ls_str          STRING
   DEFINE ls_read         STRING
   DEFINE ls_return       STRING
   DEFINE ls_cha_read     base.Channel
   DEFINE ls_para_b       LIKE type_t.chr1
   DEFINE ls_para_e       LIKE type_t.chr1
   DEFINE li_i            LIKE type_t.num5
   DEFINE ls_para_data    STRING
   DEFINE ls_para_str     STRING
   DEFINE l_sql           STRING
   DEFINE l_word          STRING


   #定義取用樣板檔案
   LET ls_slice = "slice/code_qs25.template"
   LET ls_slice = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"mdl"),ls_slice)

   #開啟樣板檔
   LET ls_cha_read = base.Channel.create()
   CALL ls_cha_read.setDelimiter("")

   CALL ls_cha_read.openFile( ls_slice CLIPPED, "r" )
   LET ls_para_b = "N"
   LET ls_para_e = "N"
   LET ls_para_data = ""
   LET ls_return = ""
   CALL g_para_data.clear()

   WHILE NOT ls_cha_read.isEof()
      LET ls_read = ls_cha_read.readLine()
      IF ls_read.getIndexOf("#hyperlink_mdls - Start -",1) THEN
         LET ls_para_b = "Y"
         CONTINUE WHILE
      END IF
      IF ls_read.getIndexOf("#hyperlink_mdls -  End  -",1) THEN
         LET ls_para_e = "Y"
         CONTINUE WHILE
      END IF

      # 擷取標誌內的資訊
      IF ls_para_b = "Y" AND ls_para_e = "N" THEN
         IF NOT cl_null(ls_para_data) THEN
            LET ls_para_data = ls_para_data, "\n"
         END IF
         LET ls_para_data = ls_para_data,ls_read
         CONTINUE WHILE
      END IF

      IF NOT cl_null(ls_return) THEN
         LET ls_return = ls_return ,"\n"
      END IF
      LET ls_return = ls_return,ls_read
   END WHILE
   CALL ls_cha_read.close()

   #產生code部分
   LET li_i = 1

   LET l_sql = "SELECT * FROM adzp152_para_tmp ",
               " WHERE field = '",lc_field,"'"
   PREPARE adzp152_para_data_pre FROM l_sql
   DECLARE adzp152_para_data_curs CURSOR FOR adzp152_para_data_pre
   FOREACH adzp152_para_data_curs INTO g_para_data[li_i].*
      LET ls_str = lc_field,lc_item_no USING "<<<","_para",li_i USING "<<<"
      CALL g_properties.addAttribute(ls_str,g_para_data[li_i].para_data)

      LET ls_para_str = ls_para_data
      # 若有符合需重複取代
      LET l_word = "${mdls}"
      WHILE ls_para_str.getIndexOf(l_word, 1) > 0
         LET ls_para_str = cl_replace_str(ls_para_str, l_word, li_i)
      END WHILE

      LET l_word = "${hyper_field_count_all}"
      WHILE ls_para_str.getIndexOf(l_word, 1) > 0
         LET ls_para_str = cl_replace_str(ls_para_str, l_word, lc_item_no)
      END WHILE

      LET ls_str = lc_field,lc_item_no USING "<<<"
      LET l_word = "${detail_hyper_field",lc_item_no USING "<<<","}"
      WHILE ls_para_str.getIndexOf(l_word, 1) > 0
         LET ls_para_str = cl_replace_str(ls_para_str, l_word, ls_str)
      END WHILE

      LET li_i = li_i + 1
      IF NOT cl_null(ls_return) THEN
         LET ls_return = ls_return ,"\n"
      END IF
      LET ls_return = ls_return,ls_para_str
   END FOREACH
   CALL g_para_data.deleteElement(li_i)

   WHILE ls_return.getIndexOf("${",1) > 0
      LET ls_return = adzp152_line_replace(ls_return)
   END WHILE

   RETURN ls_return

END FUNCTION

#+ 解析參數，轉為實際欄位(變數)
PUBLIC FUNCTION adzp152_parse_hyper_para(ps_field,ps_para)
   DEFINE ps_field        LIKE type_t.chr100    #串查欄位
   DEFINE ps_para         STRING
   DEFINE ls_para         STRING
   DEFINE ls_token        STRING
   DEFINE lst_token       base.StringTokenizer
   DEFINE ls_master_field STRING
   DEFINE ls_page_name    STRING
   DEFINE ls_para_count   LIKE type_t.num5
   DEFINE ls_cnt          LIKE type_t.num5
   DEFINE ls_data         LIKE type_t.chr200

   WHENEVER ERROR CALL cl_err_msg_log

   #先取得單身所有欄位
   LET ls_master_field = g_properties.getValue("master_all_field")

   #拆解並轉換
   LET lst_token = base.StringTokenizer.create(ps_para, ',')
   LET ls_para_count = lst_token.countTokens()
   IF cl_null(ls_para_count) THEN
      LET ls_para_count = 0
   END IF
   LET ls_cnt = 0
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      LET ls_cnt = ls_cnt + 1
      LET ls_data = ls_token

      IF ls_master_field.getIndexOf(ls_token,1) THEN
         #先確定是否在單頭
         LET ls_para = ls_para, g_properties.getValue("master_var_title"),".",ls_token
         LET ls_data = g_properties.getValue("master_var_title"),".",ls_token
      ELSE
         #若不在單頭則尋找單身
         LET ls_page_name = adzp152_find_page(ls_token,'')
         IF cl_null(ls_page_name) THEN
            #非單身欄位, 視為一般變數
            LET ls_para = ls_para, ls_token
            LET ls_data = ls_token
         ELSE
            #單身欄位, 定義變數名稱
            #註：因為欄位定義時是有截掉 '_' 的，所以在組合程式碼時，若是有用到定義的變數也須把 '_' 截掉  150428
            IF ls_token.getIndexOf('_',1) > 0 AND
               NOT ls_token.getIndexOf("_desc",1) AND
               NOT ls_token.getIndexOf("prog_",1) AND    #YSC-E30002 add
               NOT ls_token.getIndexOf("l_",1)    AND
               NOT ls_token.getIndexOf("lc_",1)   THEN

               LET ls_para = ls_para, adzp152_find_page(ls_token,''),".",ls_token.subString(1,ls_token.getIndexOf('_',1)-1)
               LET ls_data = adzp152_find_page(ls_token,''),".",ls_token.subString(1,ls_token.getIndexOf('_',1)-1)
            ELSE
               LET ls_para = ls_para, adzp152_find_page(ls_token,''),".",ls_token
               LET ls_data = adzp152_find_page(ls_token,''),".",ls_token
            END IF
         END IF
      END IF

      IF lst_token.hasMoreTokens() THEN
         LET ls_para = ls_para, ','
      END IF

      # 寫入暫存檔
      INSERT INTO adzp152_para_tmp
                  (field, para_no, para_data, para_totcount)
           VALUES (ps_field, ls_cnt, ls_data, ls_para_count)

      IF SQLCA.SQLCODE THEN
         DISPLAY "INSERT INTO adzp152_para_tmp ERROR:",SQLCA.SQLCODE
      END IF
   END WHILE

#  RETURN ls_para

END FUNCTION
# YSC-E70003 --- end ---

