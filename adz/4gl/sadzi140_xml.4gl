#+ Modify : 20160219 (No Request) by ernest : 1.表格基礎資料排除自定義欄位(DGENV=s)
#+ Modify : 20161209 (No Request) by ernest : 1.修正寫死語系
#+                                            2.修正抓取表格型態來源                        

&include "../4gl/sadzi140_mcr.inc"

IMPORT os 
IMPORT xml

SCHEMA ds

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzi140_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzi140_type.inc"

PUBLIC TYPE T_TABLE_HEAD_INFO RECORD
              INFO_MODULE  VARCHAR(10),  
              INFO_TEXT    VARCHAR(100),
              INFO_TYPE    VARCHAR(10)
            END RECORD

PRIVATE TYPE T_WEB_ALTER_TABLE_LIST RECORD
               tbl_DATE    VARCHAR(24),
               tbl_TABLE   VARCHAR(30),
               tbl_MODULE  VARCHAR(30),
               tbl_LANG    VARCHAR(10)
             END RECORD

PRIVATE TYPE T_TABLE_LIST RECORD
                  tl_table_name    VARCHAR(15),
                  tl_table_desc    VARCHAR(255),
                  tl_module_name   VARCHAR(15),
                  tl_table_type    VARCHAR(255),
                  tl_pk_columns    VARCHAR(512)
                END RECORD

#產生資料屬性相關資料的 XML (datatyps.xml)
FUNCTION sadzi140_xml_gen_table_data_types_xml(p_xml_filename)
DEFINE
  p_xml_filename STRING
DEFINE
  lo_table_data_types RECORD
                        tdt_name     VARCHAR(255),
                        tdt_type     VARCHAR(50),
                        tdt_length   VARCHAR(50),
                        tdt_nullable VARCHAR(02),
                        tdt_default  VARCHAR(50)
                      END RECORD
DEFINE 
  ls_xml_filename   STRING,
  ls_sql            STRING,
  ls_tdt_name       STRING,
  li_space          INTEGER,
  lb_result         BOOLEAN, 
  ls_xml_contents   STRING,
  lo_xml_documents  om.DomDocument,
  lo_xml_elements   om.DomNode,
  lo_xml_domnode    om.DomNode
DEFINE
  lb_return  BOOLEAN
  
  LET li_space = 2
  LET ls_xml_filename = p_xml_filename

  
  LET ls_sql = "SELECT TD.GZTD001||'.'||TD.GZTD002||':'||TD.GZTD003 tdt_name, ",
               "       TD.GZTD003   tdt_type,                                 ",
               "       TD.GZTD008   tdt_length,                               ",
               "       ''           tdt_nullable,                             ",
               "       ''           tdt_default                               ",
               "  FROM GZTD_T TD                                              ",
               " ORDER BY TD.GZTD001                                          "
  
  PREPARE lpre_TableDataTypes FROM ls_sql
  DECLARE lcur_TableDataTypes CURSOR FOR lpre_TableDataTypes

  LET lo_xml_documents = om.DomDocument.create("dataTypes")
  LET lo_xml_elements  = lo_xml_documents.getDocumentElement()
  
  OPEN lcur_TableDataTypes
  FOREACH lcur_TableDataTypes INTO lo_table_data_types.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET lo_xml_domnode = lo_xml_elements.createChild("dataType")

    IF lo_table_data_types.tdt_length IS NULL THEN
      LET ls_tdt_name = sadzi140_util_trim_str(lo_table_data_types.tdt_name)
    ELSE
      LET ls_tdt_name = sadzi140_util_trim_str(lo_table_data_types.tdt_name),"(",sadzi140_util_trim_str(lo_table_data_types.tdt_length),")"
    END IF
    
    #CALL lo_xml_domnode.setAttribute("name",sadzi140_util_trim_str(lo_table_data_types.tdt_name))
    CALL lo_xml_domnode.setAttribute("name",ls_tdt_name)
    #CALL lo_xml_domnode.setAttribute("type=",sadzi140_util_trim_str(lo_table_data_types.tdt_type))
    CALL lo_xml_domnode.setAttribute("type","")
    #CALL lo_xml_domnode.setAttribute("length=",sadzi140_util_trim_str(lo_table_data_types.tdt_length))
    CALL lo_xml_domnode.setAttribute("length","")
    CALL lo_xml_domnode.setAttribute("isnull",sadzi140_util_trim_str(lo_table_data_types.tdt_nullable))
    CALL lo_xml_domnode.setAttribute("default",sadzi140_util_trim_str(lo_table_data_types.tdt_default))

  END FOREACH
  CLOSE lcur_TableDataTypes
  
  FREE lpre_TableDataTypes
  FREE lcur_TableDataTypes

  #CALL lo_xml_elements.writeXml(ls_xml_filename)
  
  LET ls_xml_contents = lo_xml_elements.toString()
  CALL sadzi140_xml_write_file(ls_xml_filename, ls_xml_contents) RETURNING lb_result

  LET lb_return = lb_result

  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzi140_xml_gen_table_contents_xml(p_table_name,p_xml_filename,p_lang)
DEFINE
  p_table_name   STRING,
  p_xml_filename STRING,
  p_lang         STRING
DEFINE 
  ls_table_name   STRING,
  ls_xml_filename STRING,
  ls_lang         STRING,
  lb_result       BOOLEAN

  LET ls_table_name   = p_table_name
  LET ls_xml_filename = p_xml_filename
  LET ls_lang         = p_lang

  CALL sadzi140_xml_gen_table_describe(ls_table_name,ls_xml_filename,ls_lang) RETURNING lb_result
  
END FUNCTION

#Get Table Elements from Database
FUNCTION sadzi140_xml_gen_table_describe(p_table_name,p_xml_filename,p_lang)
DEFINE
  p_table_name   STRING,
  p_xml_filename STRING,
  p_lang         STRING
DEFINE
  lo_table_elements RECORD
                      dzeb002 LIKE dzeb_t.dzeb002,
                      dzeb003 LIKE dzeb_t.dzeb003,
                      dzeb006 LIKE dzeb_t.dzeb006,
                      dzeb007 LIKE dzeb_t.dzeb007,
                      dzeb008 LIKE dzeb_t.dzeb008,
                      dzeb004 LIKE dzeb_t.dzeb004,
                      dzeb005 LIKE dzeb_t.dzeb005,
                      dzep009 LIKE dzep_t.dzep009,
                      dzep010 LIKE dzep_t.dzep010,
                      dzep012 LIKE dzep_t.dzep012,
                      dzep013 LIKE dzep_t.dzep013,
                      dzep014 LIKE dzep_t.dzep014,
                      dzep017 LIKE dzep_t.dzep017,
                      dzep018 LIKE dzep_t.dzep018,
                      dzep019 LIKE dzep_t.dzep019
                    END RECORD,
  lo_tree RECORD
            dzeq006 LIKE dzeq_t.dzeq006,
            dzeq007 LIKE dzeq_t.dzeq007,
            dzeq008 LIKE dzeq_t.dzeq008,
            dzeq009 LIKE dzeq_t.dzeq009
          END RECORD,
  lo_ref_field RECORD
                 dzef002 LIKE dzef_t.dzef002,
                 dzef003 LIKE dzef_t.dzef003,
                 dzef006 LIKE dzef_t.dzef006,
                 dzef007 LIKE dzef_t.dzef007,
                 dzef008 LIKE dzef_t.dzef008,
                 dzef009 LIKE dzef_t.dzef009
               END RECORD,
  lo_multi_lang RECORD
                  dzer002 LIKE dzer_t.dzer002,
                  dzer004 LIKE dzer_t.dzer004,
                  dzer005 LIKE dzer_t.dzer005,
                  dzer006 LIKE dzer_t.dzer006,
                  dzer007 LIKE dzer_t.dzer007,
                  dzer008 LIKE dzer_t.dzer008
                END RECORD,
  lo_help_code RECORD
                 dzet002 LIKE dzet_t.dzet002,
                 dzet003 LIKE dzet_t.dzet003,
                 dzet004 LIKE dzet_t.dzet004,
                 dzet005 LIKE dzet_t.dzet005,
                 dzet006 LIKE dzet_t.dzet006,
                 dzet007 LIKE dzet_t.dzet007
               END RECORD,
  lo_column_attribute RECORD
                        dzep002 LIKE dzep_t.dzep002,
                        dzej003 LIKE dzej_t.dzej003,
                        dzep011 LIKE dzep_t.dzep011,
                        dzep012 LIKE dzep_t.dzep012,
                        dzep013 LIKE dzep_t.dzep013,
                        dzep014 LIKE dzep_t.dzep014,
                        dzep017 LIKE dzep_t.dzep017,
                        dzep018 LIKE dzep_t.dzep018,
                        dzep019 LIKE dzep_t.dzep019,
                        dzep009 LIKE dzep_t.dzep009,
                        dzep021 LIKE dzep_t.dzep021,
                        dzep020 LIKE dzep_t.dzep020,
                        dzep025 LIKE dzep_t.dzep025,
                        dzep026 LIKE dzep_t.dzep026,
                        dzep023 LIKE dzep_t.dzep023
                      END RECORD,
  lo_status_code_head RECORD
                        gzcc002  LIKE gzcc_t.gzcc002,
                        gzcc003  LIKE gzcc_t.gzcc003,
                        gzcal003 LIKE gzcal_t.gzcal003
                      END RECORD,
  lo_status_code_detail RECORD
                          gzcc004  LIKE gzcc_t.gzcc004,
                          gzcbl004 LIKE gzcbl_t.gzcbl004
                        END RECORD
DEFINE 
  ls_table_name             STRING,
  ls_xml_filename           STRING,
  ls_lang                   STRING,
  ls_sql                    STRING,
  li_space                  INTEGER,
  ls_xml_contents           STRING,
  lo_xml_documents          om.DomDocument,
  lo_xml_elements           om.DomNode,
  lo_xml_dom_node           om.DomNode,
  lo_ref_field_xml          om.DomNode,
  lo_multi_lang_xml         om.DomNode,
  lo_help_code_xml          om.DomNode,
  lo_column_attribute_xml   om.DomNode,
  lo_status_code_head_xml   om.DomNode,
  lo_status_code_detail_xml om.DomNode,
  lo_tree_detail_xml        om.DomNode,
  ls_data_length            STRING, 
  ls_max                    STRING,  
  ls_min                    STRING,  
  lo_table_head_info        T_TABLE_HEAD_INFO,
  ls_data_type              STRING,
  ls_dgenv                  STRING, #20160219
  ls_sql_cond               STRING, #20160219
  lb_result                 BOOLEAN 
DEFINE
  lb_return  BOOLEAN  
  
  LET li_space = 2
  LET ls_table_name   = p_table_name
  LET ls_xml_filename = p_xml_filename
  LET ls_lang         = p_lang

  #20160706 begin Mark , 避免到客戶端還要再執行tbl重產才能有 ud 的欄位
  {
  #20160219 begin
  LET ls_dgenv = NVL(FGL_GETENV("DGENV"),cs_dgenv_standard)

  LET ls_sql_cond = ""
  IF ls_dgenv = cs_dgenv_standard THEN 
    LET ls_sql_cond = " AND EB.DZEB022 NOT LIKE 'cdfUserDefine%' " 
  END IF 
  #20160219 end
  }
  #20160706 end
  
  CALL sadzi140_xml_get_table_head_info(ls_table_name,ls_lang) RETURNING lo_table_head_info.*
  
  #產出表格結構
  LET ls_sql = "SELECT EB.DZEB002,EBL.DZEBL003,EB.DZEB006,TD.GZTD003 DZEB007,   ",
               "       REPLACE(REPLACE(TD.GZTD008,' ',''),'.',',') DZEB008,     ",
               "       EB.DZEB004,EB.DZEB005,EP.DZEP009,EP.DZEP010,EP.DZEP012,  ",
               "       EP.DZEP013,EP.DZEP014,EP.DZEP017,EP.DZEP018,EP.DZEP019   ",
               "  FROM DZEB_T EB                                                ",
               "  LEFT OUTER JOIN GZTD_T TD ON TD.GZTD001 = EB.DZEB006          ",      
               "  LEFT OUTER JOIN DZEP_T EP ON EP.DZEP001 = EB.DZEB001          ",      
               "                           AND EP.DZEP002 = EB.DZEB002          ",      
               "  LEFT OUTER JOIN DZEBL_T EBL ON EBL.DZEBL001 = EB.DZEB002      ",
               "                             AND EBL.DZEBL002 = '",ls_lang,"'   ",
               " WHERE 1=1                                                      ",
               "   AND EB.DZEB001 = '",ls_table_name.toLowerCase(),"'           ",
               ls_sql_cond, #20160219
               " ORDER BY EB.DZEB021,EB.DZEB002                                 "
               
  PREPARE lpre_table_contents FROM ls_sql
  DECLARE lcur_table_contents CURSOR FOR lpre_table_contents

  LET lo_xml_documents = om.DomDocument.create("table")
  LET lo_xml_elements  = lo_xml_documents.getDocumentElement()
  CALL lo_xml_elements.setAttribute("name",ls_table_name)
  CALL lo_xml_elements.setAttribute("module",lo_table_head_info.INFO_MODULE)
  CALL lo_xml_elements.setAttribute("text",lo_table_head_info.INFO_TEXT)
  CALL lo_xml_elements.setAttribute("type",lo_table_head_info.INFO_TYPE)
  CALL lo_xml_elements.setAttribute("version","1")
  
  OPEN lcur_table_contents
  FOREACH lcur_table_contents INTO lo_table_elements.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_data_length = lo_table_elements.DZEB008
    LET ls_data_length = ls_data_length.trim()
    
    IF NVL(ls_data_length,cs_null_value) = cs_null_value THEN
      LET ls_data_type = sadzi140_util_trim_str(lo_table_elements.DZEB007)
    ELSE
      LET ls_data_type = sadzi140_util_trim_str(lo_table_elements.DZEB007),"(",
                         sadzi140_util_trim_str(lo_table_elements.DZEB008),")"
    END IF
    
    LET lo_xml_dom_node = lo_xml_elements.createChild("column")
    
    CALL lo_xml_dom_node.setAttribute("name",sadzi140_util_trim_str(lo_table_elements.DZEB002))
    CALL lo_xml_dom_node.setAttribute("text",sadzi140_util_trim_str(lo_table_elements.DZEB003))
    CALL lo_xml_dom_node.setAttribute("attribute",sadzi140_util_trim_str(lo_table_elements.DZEB006))
    CALL lo_xml_dom_node.setAttribute("type",ls_data_type)
    CALL lo_xml_dom_node.setAttribute("pk",sadzi140_util_trim_str(lo_table_elements.DZEB004))
    CALL lo_xml_dom_node.setAttribute("req",sadzi140_util_trim_str(lo_table_elements.DZEB005))

    {    
    #CALL lo_xml_dom_node.setAttribute("width",sadzi140_util_trim_str(lo_table_elements.DZEB008))
    CALL lo_xml_dom_node.setAttribute("item",sadzi140_util_trim_str(lo_table_elements.DZEP010))
    CALL lo_xml_dom_node.setAttribute("default",sadzi140_util_trim_str(lo_table_elements.DZEP012))
    CALL lo_xml_dom_node.setAttribute("max",sadzi140_util_trim_str(lo_table_elements.DZEP013))
    CALL lo_xml_dom_node.setAttribute("min",sadzi140_util_trim_str(lo_table_elements.DZEP014))
    #CALL lo_xml_dom_node.setAttribute("e_zoom",sadzi140_util_trim_str(lo_table_elements.DZEP017))
    CALL lo_xml_dom_node.setAttribute("i_zoom",sadzi140_util_trim_str(lo_table_elements.DZEP017))
    CALL lo_xml_dom_node.setAttribute("c_zoom",sadzi140_util_trim_str(lo_table_elements.DZEP018))
    #CALL lo_xml_dom_node.setAttribute("chk_exist",sadzi140_util_trim_str(lo_table_elements.DZEP019))
    CALL lo_xml_dom_node.setAttribute("chk_ref",sadzi140_util_trim_str(lo_table_elements.DZEP019))
    CALL lo_xml_dom_node.setAttribute("widget_width",sadzi140_util_trim_str(lo_table_elements.DZEP009))
    }
    
  END FOREACH
  CLOSE lcur_table_contents
  
  FREE lpre_table_contents
  FREE lcur_table_contents

  #產出欄位屬性
  LET ls_sql = "SELECT EP.DZEP002,EJ.DZEJ003,EP.DZEP011,EP.DZEP012,EP.DZEP013,",
               "       EP.DZEP014,EP.DZEP017,EP.DZEP018,EP.DZEP019,EP.DZEP009,",
               "       EP.DZEP021,EP.DZEP020,EP.DZEP025,EP.DZEP026,EP.DZEP023 ", 
               "  FROM DZEP_T EP                                              ",
               " INNER JOIN DZEB_T EB ON EB.DZEB001 = EP.DZEP001              ",
               "                     AND EB.DZEB002 = EP.DZEP002              ",
               "  LEFT OUTER JOIN DZEJ_T EJ ON EP.DZEP010 = EJ.DZEJ002        ",
               "                           AND EJ.DZEJ001 = 'GENERO_WIDGETS'  ",                  
               " WHERE 1=1                                                    ",
               "   AND EP.DZEP001 = '",ls_table_name,"'                       ",
               ls_sql_cond, #20160219
               " ORDER BY EB.DZEB021                                          "
  
  PREPARE lpre_column_attribute FROM ls_sql
  DECLARE lcur_column_attribute CURSOR FOR lpre_column_attribute
  
  LET lo_xml_dom_node  = lo_xml_elements.createChild("col_attr")
  
  OPEN lcur_column_attribute
  FOREACH lcur_column_attribute INTO lo_column_attribute.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET ls_max = sadzi140_util_trim_str(lo_column_attribute.DZEP025),sadzi140_util_trim_str(lo_column_attribute.DZEP013)
    LET ls_min = sadzi140_util_trim_str(lo_column_attribute.DZEP026),sadzi140_util_trim_str(lo_column_attribute.DZEP014)
    
    LET lo_column_attribute_xml = lo_xml_dom_node.createChild("field")
    CALL lo_column_attribute_xml.setAttribute("name",sadzi140_util_trim_str(lo_column_attribute.DZEP002)) 
    CALL lo_column_attribute_xml.setAttribute("widget",sadzi140_util_trim_str(lo_column_attribute.DZEJ003))
    CALL lo_column_attribute_xml.setAttribute("items",sadzi140_util_trim_str(lo_column_attribute.DZEP011)) 
    CALL lo_column_attribute_xml.setAttribute("default",sadzi140_util_trim_str(lo_column_attribute.DZEP012)) 
    CALL lo_column_attribute_xml.setAttribute("max_compare",sadzi140_util_trim_str(lo_column_attribute.DZEP025)) 
    CALL lo_column_attribute_xml.setAttribute("max",sadzi140_util_trim_str(lo_column_attribute.DZEP013)) 
    CALL lo_column_attribute_xml.setAttribute("min_compare",sadzi140_util_trim_str(lo_column_attribute.DZEP026)) 
    CALL lo_column_attribute_xml.setAttribute("min",sadzi140_util_trim_str(lo_column_attribute.DZEP014)) 
    CALL lo_column_attribute_xml.setAttribute("i_zoom",sadzi140_util_trim_str(lo_column_attribute.DZEP017)) 
    CALL lo_column_attribute_xml.setAttribute("c_zoom",sadzi140_util_trim_str(lo_column_attribute.DZEP018)) 
    CALL lo_column_attribute_xml.setAttribute("chk_ref",sadzi140_util_trim_str(lo_column_attribute.DZEP019)) 
    CALL lo_column_attribute_xml.setAttribute("widget_width",sadzi140_util_trim_str(lo_column_attribute.DZEP009))
    CALL lo_column_attribute_xml.setAttribute("format",sadzi140_util_trim_str(lo_column_attribute.DZEP021))
    CALL lo_column_attribute_xml.setAttribute("prog_rel",sadzi140_util_trim_str(lo_column_attribute.DZEP020)) 
    CALL lo_column_attribute_xml.setAttribute("case",sadzi140_util_trim_str(lo_column_attribute.DZEP023)) 
    
  END FOREACH
  CLOSE lcur_column_attribute
  
  FREE lpre_column_attribute
  FREE lcur_column_attribute  
  
  #產出樹狀結構
  LET ls_sql = "SELECT EQ.DZEQ006,EQ.DZEQ007,EQ.DZEQ008,EQ.DZEQ009                  ",
               "  FROM DZEQ_T EQ                                                    ",
               " WHERE EQ.DZEQ001 = '",ls_table_name,"'                             ",
               {
               "UNION                                                               ",
               "SELECT EQS.DZEQ006,EQS.DZEQ007,EQS.DZEQ008,EQS.DZEQ009              ",
               "  FROM DZEQ_T EQS                                                   ",
               " WHERE EQS.DZEQ001 = (                                              ",
               "                       SELECT EQ.DZEQ008                            ",
               "                         FROM DZEQ_T EQ                             ",
               "                        WHERE EQ.DZEQ001 = '",ls_table_name,"'      ", 
               "                          AND EQ.DZEQ007 = 'speed'                  ",
               "                     )                                              ",
               }
               " ORDER BY 1                                                         "
  
  PREPARE lpre_tree_structure FROM ls_sql
  DECLARE lcur_tree_structure CURSOR FOR lpre_tree_structure
  
  LET lo_xml_dom_node = lo_xml_elements.createChild("tree")
  
  {
  CALL lo_xml_dom_node.setAttribute("id",ls_table_name)
  CALL lo_xml_dom_node.setAttribute("type","")
  CALL lo_xml_dom_node.setAttribute("lid","")
  CALL lo_xml_dom_node.setAttribute("pid","")
  CALL lo_xml_dom_node.setAttribute("desc","")
  CALL lo_xml_dom_node.setAttribute("speed","")
  CALL lo_xml_dom_node.setAttribute("stype","")
  CALL lo_xml_dom_node.setAttribute("slid","")
  CALL lo_xml_dom_node.setAttribute("spid","")
  }
  
  OPEN lcur_tree_structure
  FOREACH lcur_tree_structure INTO lo_tree.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    CASE lo_tree.DZEQ007
      WHEN "type"
        LET lo_tree_detail_xml = lo_xml_dom_node.createChild("type")
        #CALL lo_xml_dom_node.setAttribute("type",lo_tree.DZEQ008)
      WHEN "id"
        LET lo_tree_detail_xml = lo_xml_dom_node.createChild("id")
        #CALL lo_xml_dom_node.setAttribute("lid",lo_tree.DZEQ009)
      WHEN "pid"
        LET lo_tree_detail_xml = lo_xml_dom_node.createChild("pid")
        #CALL lo_xml_dom_node.setAttribute("pid",lo_tree.DZEQ009)
      WHEN "desc"
        LET lo_tree_detail_xml = lo_xml_dom_node.createChild("desc")
        #CALL lo_xml_dom_node.setAttribute("desc",lo_tree.DZEQ008)
      WHEN "speed"
        LET lo_tree_detail_xml = lo_xml_dom_node.createChild("speed")
        #CALL lo_xml_dom_node.setAttribute("speed",lo_tree.DZEQ008)
      WHEN "stype"
        LET lo_tree_detail_xml = lo_xml_dom_node.createChild("stype")
        #CALL lo_xml_dom_node.setAttribute("stype",lo_tree.DZEQ008)
      WHEN "sid"
        LET lo_tree_detail_xml = lo_xml_dom_node.createChild("sid")
        #CALL lo_xml_dom_node.setAttribute("slid",lo_tree.DZEQ009)
      WHEN "spid"
        LET lo_tree_detail_xml = lo_xml_dom_node.createChild("spid")
        #CALL lo_xml_dom_node.setAttribute("spid",lo_tree.DZEQ009)
    OTHERWISE  
    END CASE

    CALL lo_tree_detail_xml.setAttribute("no",lo_tree.DZEQ006)
    CALL lo_tree_detail_xml.setAttribute("table",lo_tree.DZEQ008)
    CALL lo_tree_detail_xml.setAttribute("col",lo_tree.DZEQ009)
    
  END FOREACH
  CLOSE lcur_tree_structure
  
  FREE lpre_tree_structure
  FREE lcur_tree_structure

  #產出參考結構
  LET ls_sql = "SELECT EF.DZEF002,EF.DZEF003,EF.DZEF006,EF.DZEF007,EF.DZEF008, ",
               "       EF.DZEF009                                              ",
               "  FROM DZEF_T EF                                               ",
               " WHERE EF.DZEF001 = '",ls_table_name,"'                         ",
               " ORDER BY EF.DZEF002                                           "
  
  PREPARE lpre_ref_field_structure FROM ls_sql
  DECLARE lcur_ref_field_structure CURSOR FOR lpre_ref_field_structure
  
  LET lo_xml_dom_node  = lo_xml_elements.createChild("ref_field")
  
  OPEN lcur_ref_field_structure
  FOREACH lcur_ref_field_structure INTO lo_ref_field.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET lo_ref_field_xml = lo_xml_dom_node.createChild("field")
    CALL lo_ref_field_xml.setAttribute("depend_table",ls_table_name)
    CALL lo_ref_field_xml.setAttribute("depend_field",lo_ref_field.DZEF002)
    CALL lo_ref_field_xml.setAttribute("correspon_key",lo_ref_field.DZEF003)
    CALL lo_ref_field_xml.setAttribute("ref_table",lo_ref_field.DZEF006)
    CALL lo_ref_field_xml.setAttribute("ref_fk",lo_ref_field.DZEF007)
    CALL lo_ref_field_xml.setAttribute("ref_dlang",lo_ref_field.DZEF009)
    CALL lo_ref_field_xml.setAttribute("ref_rtn",lo_ref_field.DZEF008)
    
  END FOREACH
  CLOSE lcur_ref_field_structure
  
  FREE lpre_ref_field_structure
  FREE lcur_ref_field_structure  

  #產出多語言結構
  LET ls_sql = "SELECT ER.DZER002,ER.DZER004,ER.DZER005,ER.DZER006,ER.DZER007, ",
               "       ER.DZER008                                              ",
               "  FROM DZER_T ER                                               ",
               " WHERE ER.DZER001 = '",ls_table_name,"'                         ",
               " ORDER BY ER.DZER002                                           "
  
  PREPARE lpre_multi_lang_structure FROM ls_sql
  DECLARE lcur_multi_lang_structure CURSOR FOR lpre_multi_lang_structure
  
  LET lo_xml_dom_node = lo_xml_elements.createChild("multi_lang")
  
  OPEN lcur_multi_lang_structure
  FOREACH lcur_multi_lang_structure INTO lo_multi_lang.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET lo_multi_lang_xml = lo_xml_dom_node.createChild("field")
    CALL lo_multi_lang_xml.setAttribute("depend_table",ls_table_name)
    CALL lo_multi_lang_xml.setAttribute("depend_field",lo_multi_lang.DZER002)
    CALL lo_multi_lang_xml.setAttribute("correspon_key",lo_multi_lang.DZER004)
    CALL lo_multi_lang_xml.setAttribute("lang_table",lo_multi_lang.DZER005)
    CALL lo_multi_lang_xml.setAttribute("lang_fk",lo_multi_lang.DZER006)
    CALL lo_multi_lang_xml.setAttribute("lang_dlang",lo_multi_lang.DZER008)
    CALL lo_multi_lang_xml.setAttribute("lang_rtn",lo_multi_lang.DZER007)
    
  END FOREACH
  CLOSE lcur_multi_lang_structure
  
  FREE lpre_multi_lang_structure
  FREE lcur_multi_lang_structure

  #產出助記碼結構
  LET ls_sql = "SELECT ET.DZET002,ET.DZET003,ET.DZET004,ET.DZET005,ET.DZET006, ",
               "       ET.DZET007                                              ",
               "  FROM DZET_T ET                                               ",
               " WHERE ET.DZET001 = '",ls_table_name,"'                         ",
               " ORDER BY ET.DZET002                                           "
  
  PREPARE lpre_help_code_structure FROM ls_sql
  DECLARE lcur_help_code_structure CURSOR FOR lpre_help_code_structure
  
  LET lo_xml_dom_node = lo_xml_elements.createChild("help_code")
  
  OPEN lcur_help_code_structure
  FOREACH lcur_help_code_structure INTO lo_help_code.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET lo_help_code_xml = lo_xml_dom_node.createChild("field")
    CALL lo_help_code_xml.setAttribute("depend_table",ls_table_name)
    CALL lo_help_code_xml.setAttribute("depend_field",lo_help_code.DZET002)
    CALL lo_help_code_xml.setAttribute("correspon_key",lo_help_code.DZET003)
    CALL lo_help_code_xml.setAttribute("help_table",lo_help_code.DZET004)
    CALL lo_help_code_xml.setAttribute("help_fk",lo_help_code.DZET005)
    CALL lo_help_code_xml.setAttribute("help_dlang",lo_help_code.DZET007)
    CALL lo_help_code_xml.setAttribute("help_rtn",lo_help_code.DZET006)  
    
  END FOREACH
  CLOSE lcur_help_code_structure
  FREE lpre_help_code_structure
  FREE lcur_help_code_structure

  ##begin of 產出狀態碼結構
  #表頭結構
  LET ls_sql = "SELECT DISTINCT GZCC002, GZCC003, GZCAL003            ",
               "  FROM GZCC_T                                         ",
               "  LEFT OUTER JOIN GZCAL_T ON GZCAL001 = GZCC003       ",
               "                         AND GZCAL002 = '",ls_lang,"' ",
               " WHERE GZCC001 = '",ls_table_name,"'                  ",
               "   AND GZCCSTUS = 'Y'                                 "
                
  PREPARE lpre_status_code_head_structure FROM ls_sql
  DECLARE lcur_status_code_head_structure CURSOR FOR lpre_status_code_head_structure
  
  LET lo_xml_dom_node = lo_xml_elements.createChild("scc")
  
  OPEN lcur_status_code_head_structure
  FETCH lcur_status_code_head_structure INTO lo_status_code_head.*
  CLOSE lcur_status_code_head_structure

  IF NVL(lo_status_code_head.GZCC002,cs_null_value) <> cs_null_value THEN 
    LET lo_status_code_head_xml = lo_xml_dom_node.createChild("field")
    CALL lo_status_code_head_xml.setAttribute("name",lo_status_code_head.GZCC002)
    CALL lo_status_code_head_xml.setAttribute("category",lo_status_code_head.GZCC003)
    CALL lo_status_code_head_xml.setAttribute("desc",lo_status_code_head.GZCAL003)
  END IF    
    
  FREE lpre_status_code_head_structure
  FREE lcur_status_code_head_structure

  #明細結構
  LET ls_sql = "SELECT GZCC004, GZCBL004                        ",
               "  FROM GZCC_T                                   ",
               "  LEFT JOIN GZCBL_T ON GZCBL001 = GZCC003       ",
               "                   AND GZCBL002 = GZCC004       ",
               "                   AND GZCBL003 = '",ls_lang,"' ",
               " WHERE GZCC001 = '",ls_table_name,"'            ",
               "   AND GZCCSTUS = 'Y'                           ",
               " ORDER BY GZCC006                               "
                 
  PREPARE lpre_status_code_detail_structure FROM ls_sql
  DECLARE lcur_status_code_detail_structure CURSOR FOR lpre_status_code_detail_structure
  
  OPEN lcur_status_code_detail_structure
  FOREACH lcur_status_code_detail_structure INTO lo_status_code_detail.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET lo_status_code_detail_xml = lo_status_code_head_xml.createChild("code")
    CALL lo_status_code_detail_xml.setAttribute("value",lo_status_code_detail.GZCC004)
    CALL lo_status_code_detail_xml.setAttribute("desc",lo_status_code_detail.GZCBL004)
    
  END FOREACH
  CLOSE lcur_status_code_detail_structure
  FREE lpre_status_code_detail_structure
  FREE lcur_status_code_detail_structure
  ##end of 產出狀態碼結構
  
  #DISPLAY "XML File : ",ls_xml_filename
  #CALL lo_xml_elements.writeXml(ls_xml_filename)
  
  LET ls_xml_contents = lo_xml_elements.toString()
  CALL sadzi140_xml_write_file(ls_xml_filename, ls_xml_contents) RETURNING lb_result

  LET lb_return = lb_result

  RETURN lb_return

END FUNCTION

FUNCTION sadzi140_xml_regen_base_tables_data(p_xml_filename,p_lang,p_table_name)
DEFINE
  p_xml_filename STRING,
  p_lang         STRING, 
  p_table_name   STRING 
DEFINE
  ls_xml_filename STRING,
  ls_lang         STRING, 
  ls_table_name   STRING,
  lb_result       BOOLEAN

  LET ls_xml_filename = p_xml_filename
  LET ls_lang         = p_lang
  LET ls_table_name   = p_table_name

  IF os.Path.EXISTS(ls_xml_filename) THEN
    CALL sadzi140_xml_refresh_table_list(ls_xml_filename,ls_lang,ls_table_name) RETURNING lb_result
    DISPLAY IIF(lb_result,cs_success_tag,cs_error_tag),"Refresh '",ls_xml_filename,"' ",IIF(lb_result,"successed","failed")," !"
  ELSE 
    CALL sadzi140_xml_gen_table_catalog(ls_xml_filename,ls_lang) RETURNING lb_result
    DISPLAY IIF(lb_result,cs_success_tag,cs_error_tag),"Create '",ls_xml_filename,"' ",IIF(lb_result,"successed","failed")," !"
  END IF
  
END FUNCTION 

#Refresh table list tables.xml
FUNCTION sadzi140_xml_refresh_table_list(p_xml_filename,p_lang,p_table_name)
DEFINE
  p_xml_filename STRING,
  p_lang         STRING,
  p_table_name   STRING
DEFINE
  ls_xml_filename  STRING,
  ls_lang          STRING, 
  ls_table_name    STRING,
  lo_table_list    T_TABLE_LIST,
  ls_SQL           STRING,
  {
  lo_xml_documents xml.DomDocument,
  lo_xml_elements  xml.DomNode,
  lo_xml_domnode   xml.DomNode,
  }
  lo_xml_documents om.DomDocument,
  lo_xml_elements  om.DomNode,
  lo_xml_domnode   om.DomNode,
  lo_xml_nodelst   om.NodeList,
  ls_xml_contents  STRING,
  ls_find_str      STRING,
  ls_temp_str      STRING,
  ls_node_name     STRING,
  li_count         INTEGER,
  lb_result        BOOLEAN
DEFINE
  lb_return  BOOLEAN
  
  LET ls_xml_filename = p_xml_filename
  LET ls_lang         = p_lang
  LET ls_table_name   = p_table_name.trim()

  LET lb_result = TRUE
  LET li_count  = 1

  LET ls_SQL = "SELECT EA.DZEA001,EAL.DZEAL003,EA.DZEA003,EA.DZEA004||'.'||CBL.GZCBL004 DZEA004,ED.DZED004 ", #20161209                   
               "  FROM DZEA_T EA                                                                           ",
               "  LEFT OUTER JOIN DZEAL_T EAL ON EAL.DZEAL002 = '",ls_lang,"'                              ", #20161209                 
               "                             AND EAL.DZEAL001 = EA.DZEA001                                 ",                       
               "  LEFT OUTER JOIN DZED_T ED ON ED.DZED001 = EA.DZEA001                                     ",
               "                           AND ED.DZED003 = 'P'                                            ",              
               "                           AND ED.DZED002 LIKE '%_pk%'                                     ",
               "  LEFT OUTER JOIN GZCBL_T CBL ON CBL.GZCBL001 = 256                                        ", #20161209
               "                             AND CBL.GZCBL002 = EA.DZEA004                                 ", #20161209
               "                             AND CBL.GZCBL003 = '",ls_lang,"'                              ", #20161209
               " WHERE 1=1                                                                                 ",
               "   AND EA.DZEA001 = '",ls_table_name,"'                                                    ",
               " ORDER BY EA.DZEA001                                                                       "   
               
  PREPARE lpre_refresh_table_list FROM ls_SQL
  DECLARE lcur_refresh_table_list CURSOR FOR lpre_refresh_table_list

  OPEN lcur_refresh_table_list
  FETCH lcur_refresh_table_list INTO lo_table_list.*
  CLOSE lcur_refresh_table_list

  TRY 
    LET lo_xml_documents = om.DomDocument.createFromXmlFile(ls_xml_filename)
  CATCH 
    LET lb_result = FALSE
    DISPLAY cs_error_tag,"Load table.xml error !"
  END TRY
 
  #LET lo_xml_elements = lo_xml_documents.getDocumentElement()
  #LET lo_xml_domnode = lo_xml_elements.getFirstChildElement()
  LET lo_xml_elements = lo_xml_documents.getDocumentElement()

  LET ls_find_str = "//tables/table[@name=\"",ls_table_name,"\"]"
  LET lo_xml_nodelst = lo_xml_elements.selectByPath(ls_find_str)

  IF lo_xml_nodelst.getLength() > 0 THEN
    LET lo_xml_domnode = lo_xml_nodelst.item(1)
    #移除子節點
    CALL lo_xml_domnode.removeChild(lo_xml_domnode)
  ELSE
    LET lo_xml_domnode = lo_xml_elements.createChild("table")
  END IF

  CALL lo_xml_domnode.setAttribute("name",lo_table_list.tl_table_name)
  CALL lo_xml_domnode.setAttribute("desc",lo_table_list.tl_table_desc)
  CALL lo_xml_domnode.setAttribute("module",lo_table_list.tl_module_name)
  CALL lo_xml_domnode.setAttribute("type",lo_table_list.tl_table_type)
  CALL lo_xml_domnode.setAttribute("pk",lo_table_list.tl_pk_columns)
  
  #產生Footing Column List
  CALL sadzi140_xml_gen_fk_table_list(lo_table_list.tl_table_name,lo_xml_domnode)
  #產生Foreign(Referenced) Column List
  #CALL sadzi140_xml_gen_rk_table_list(lo_table_list.tl_table_name,lo_xml_domnode)
  
  FREE lpre_refresh_table_list
  FREE lcur_refresh_table_list

  #CALL lo_xml_elements.writeXml(ls_xml_filename)

  LET ls_xml_contents = lo_xml_elements.toString()
  CALL sadzi140_xml_write_file(ls_xml_filename, ls_xml_contents) RETURNING lb_result

  LET lb_return = lb_result

  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzi140_xml_gen_table_list(p_xml_filename,p_lang)
DEFINE
  p_xml_filename STRING,
  p_lang         STRING 
DEFINE 
  ls_xml_filename  STRING,
  ls_lang          STRING,
  lb_result        BOOLEAN

  LET ls_xml_filename = p_xml_filename
  LET ls_lang = p_lang

  CALL sadzi140_xml_gen_table_catalog(ls_xml_filename,ls_lang) RETURNING lb_result
  
END FUNCTION 

#Get Table List from Database
FUNCTION sadzi140_xml_gen_table_catalog(p_xml_filename,p_lang)
DEFINE
  p_xml_filename STRING,
  p_lang         STRING 
DEFINE 
  ls_xml_filename  STRING,
  ls_lang          STRING, 
  lo_table_list    T_TABLE_LIST,
  ls_SQL           STRING,
  lo_xml_documents om.DomDocument,
  lo_xml_elements  om.DomNode,
  lo_xml_domnode   om.DomNode,
  ls_xml_contents  STRING,
  ls_temp_str      STRING,
  lb_result        BOOLEAN
DEFINE
  lb_return  BOOLEAN
  
  LET ls_xml_filename = p_xml_filename
  LET ls_lang = p_lang

  LET ls_SQL = "SELECT EA.DZEA001,EAL.DZEAL003,EA.DZEA003,EA.DZEA004||'.'||CBL.GZCBL004 DZEA004,ED.DZED004 ", #20161209  
               "  FROM DZEA_T EA                                                                           ",
               "  LEFT OUTER JOIN DZEAL_T EAL ON EAL.DZEAL002 = '",ls_lang,"'                              ", #20161209
               "                             AND EAL.DZEAL001 = EA.DZEA001                                 ",                       
               "  LEFT OUTER JOIN DZED_T ED ON ED.DZED001 = EA.DZEA001                                     ",
               "                           AND ED.DZED003 = 'P'                                            ",              
               "                           AND ED.DZED002 LIKE '%_pk%'                                     ",
               "  LEFT OUTER JOIN GZCBL_T CBL ON CBL.GZCBL001 = 256                                        ", #20161209
               "                             AND CBL.GZCBL002 = EA.DZEA004                                 ", #20161209
               "                             AND CBL.GZCBL003 = '",ls_lang,"'                              ", #20161209
               " WHERE 1=1                                                                                 ",
               " ORDER BY EA.DZEA001                                                                       "   
               
  PREPARE lpre_gen_table_list FROM ls_SQL
  DECLARE lcur_gen_table_list CURSOR FOR lpre_gen_table_list

  LET lo_xml_documents = om.DomDocument.create("tables")
  LET lo_xml_elements  = lo_xml_documents.getDocumentElement()
  
  OPEN lcur_gen_table_list
  FOREACH lcur_gen_table_list INTO lo_table_list.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET lo_xml_domnode = lo_xml_elements.createChild("table")

    #LET ls_temp_str = lo_table_list.tl_module_name
    #LET lo_table_list.tl_module_name = ls_temp_str.toLowerCase()

    CALL lo_xml_domnode.setAttribute("name",lo_table_list.tl_table_name)
    CALL lo_xml_domnode.setAttribute("desc",lo_table_list.tl_table_desc)
    CALL lo_xml_domnode.setAttribute("module",lo_table_list.tl_module_name)
    CALL lo_xml_domnode.setAttribute("type",lo_table_list.tl_table_type)
    CALL lo_xml_domnode.setAttribute("pk",lo_table_list.tl_pk_columns)
    
    #產生Footing Column List
    CALL sadzi140_xml_gen_fk_table_list(lo_table_list.tl_table_name,lo_xml_domnode)
    #產生Foreign(Referenced) Column List
    #CALL sadzi140_xml_gen_rk_table_list(lo_table_list.tl_table_name,lo_xml_domnode)
    
  END FOREACH
  CLOSE lcur_gen_table_list
  
  FREE lpre_gen_table_list
  FREE lcur_gen_table_list

  #CALL lo_xml_elements.writeXml(ls_xml_filename)
  
  LET ls_xml_contents = lo_xml_elements.toString()
  CALL sadzi140_xml_write_file(ls_xml_filename, ls_xml_contents) RETURNING lb_result

  LET lb_return = lb_result

  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzi140_xml_gen_fk_table_list(p_table_name,p_xml_domnode)
DEFINE
  p_table_name  STRING,
  p_xml_domnode om.DomNode 
DEFINE
  lo_fk_table_list RECORD
                     table_name VARCHAR(15),
                     fk_detail  VARCHAR(1024),
                     fk_table   VARCHAR(255),
                     fk_master  VARCHAR(1024)
                   END RECORD
DEFINE 
  ls_table_name     STRING,
  ls_SQL            STRING,
  lo_xml_fk_domnode om.DomNode

  LET ls_table_name = p_table_name
               
  LET ls_SQL = "SELECT ED.DZED002,ED.DZED004,ED.DZED005,ED.DZED006 ", 
               "  FROM DZED_T ED                                   ",
               " WHERE ED.DZED001 = '",ls_table_name,"'            ",
               "   AND ED.DZED003 = 'F'                            "
                  
  PREPARE lpre_fk_table_list FROM ls_SQL
  DECLARE lcur_fk_table_list CURSOR FOR lpre_fk_table_list

  OPEN lcur_fk_table_list
  FOREACH lcur_fk_table_list INTO lo_fk_table_list.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET lo_xml_fk_domnode = p_xml_domnode.createChild("fk")

    CALL lo_xml_fk_domnode.setAttribute("name",lo_fk_table_list.table_name)
    CALL lo_xml_fk_domnode.setAttribute("fk_detail",lo_fk_table_list.fk_detail)
    CALL lo_xml_fk_domnode.setAttribute("fk_table",lo_fk_table_list.fk_table)
    CALL lo_xml_fk_domnode.setAttribute("fk_master",lo_fk_table_list.fk_master)
    
  END FOREACH
  CLOSE lcur_fk_table_list
  
  FREE lpre_fk_table_list
  FREE lcur_fk_table_list
  
END FUNCTION

FUNCTION sadzi140_xml_gen_rk_table_list(p_table_name,p_xml_domnode)
DEFINE
  p_table_name  STRING,
  p_xml_domnode om.DomNode 
DEFINE
  lo_rk_table_list RECORD
                     table_name VARCHAR(15),
                     rk_detail  VARCHAR(1024),
                     rk_table   VARCHAR(255),
                     rk_master  VARCHAR(1024)
                   END RECORD
DEFINE 
  ls_table_name     STRING,
  ls_SQL            STRING,
  lo_xml_rk_domnode om.DomNode

  LET ls_table_name = p_table_name
               
  LET ls_SQL = "SELECT ED.DZED002,ED.DZED004,ED.DZED005,ED.DZED006 ", 
               "  FROM DZED_T ED                                   ",
               " WHERE ED.DZED001 = '",ls_table_name,"'            ",
               "   AND ED.DZED003 = 'R'                            "
                  
  PREPARE lpre_rk_table_list FROM ls_SQL
  DECLARE lcur_rk_table_list CURSOR FOR lpre_rk_table_list

  OPEN lcur_rk_table_list
  FOREACH lcur_rk_table_list INTO lo_rk_table_list.*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET lo_xml_rk_domnode = p_xml_domnode.createChild("rk")

    CALL lo_xml_rk_domnode.setAttribute("name",lo_rk_table_list.table_name)
    CALL lo_xml_rk_domnode.setAttribute("rk_detail",lo_rk_table_list.rk_detail)
    CALL lo_xml_rk_domnode.setAttribute("rk_table",lo_rk_table_list.rk_table)
    CALL lo_xml_rk_domnode.setAttribute("rk_master",lo_rk_table_list.rk_master)
    
  END FOREACH
  CLOSE lcur_rk_table_list
  
  FREE lpre_rk_table_list
  FREE lcur_rk_table_list
  
END FUNCTION

#Get Table List for tbl update
FUNCTION sadzi140_xml_get_web_alter_table_list()
DEFINE
  lo_web_alter_table_list DYNAMIC ARRAY OF T_WEB_ALTER_TABLE_LIST,
  ls_SQL   STRING,
  li_recs  INTEGER

  LET ls_SQL = "SELECT TO_CHAR(EY.DZEY001,'YYYY/MM/DD') tbl_DATE,           ", 
               "       EY.DZEY002||'.tbl'               tbl_TABLE,          ", 
               "       EA.DZEA003                       tbl_MODULE,         ", 
               "       EAL.DZEAL002                     tbl_LANG            ", 
               "  FROM DZEY_T EY                                            ", 
               "  LEFT OUTER JOIN DZEA_T EA ON EA.DZEA001 = EY.DZEY002      ", 
               "  LEFT OUTER JOIN DZEAL_T EAL ON EAL.DZEAL001 = EY.DZEY002  ",
               " WHERE EY.DZEY001 >= TRUNC(SYSDATE) - 7                     ", -- 只取7天內的清單 
               " ORDER BY 1,2,3,4                                           " 
               
  PREPARE lpre_get_web_alter_table_list FROM ls_SQL
  DECLARE lcur_get_web_alter_table_list CURSOR FOR lpre_get_web_alter_table_list

  LET li_recs = 1
  
  OPEN lcur_get_web_alter_table_list
  FOREACH lcur_get_web_alter_table_list INTO lo_web_alter_table_list[li_recs].*
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF
    
    LET li_recs = li_recs + 1
    
  END FOREACH
  CLOSE lcur_get_web_alter_table_list

  CALL lo_web_alter_table_list.deleteElement(li_recs) 
  
  FREE lpre_get_web_alter_table_list
  FREE lcur_get_web_alter_table_list

  RETURN lo_web_alter_table_list 
  
END FUNCTION

FUNCTION sadzi140_xml_gen_web_alter_table_xml(p_web_alter_table_list,p_xml_filename,p_lang)
DEFINE
  p_web_alter_table_list DYNAMIC ARRAY OF T_WEB_ALTER_TABLE_LIST,
  p_xml_filename         STRING,
  p_lang                 STRING 
DEFINE
  lo_web_alter_table_list DYNAMIC ARRAY OF T_WEB_ALTER_TABLE_LIST,
  ls_xml_filename  STRING,
  ls_lang          STRING, 
  li_loop          INTEGER, 
  lo_xml_documents om.DomDocument,
  lo_xml_elements  om.DomNode,
  lo_xml_domnode   om.DomNode,
  ls_curr_date     STRING,
  ls_prev_date     STRING,
  ls_xml_contents  STRING,
  lb_result        BOOLEAN  
DEFINE
  lb_return  BOOLEAN  

  LET lo_web_alter_table_list = p_web_alter_table_list
  LET ls_xml_filename = p_xml_filename
  LET ls_lang = p_lang

  LET lo_xml_documents = om.DomDocument.create("table_list")
  LET lo_xml_elements  = lo_xml_documents.getDocumentElement()
  CALL lo_xml_elements.setAttribute("sys_lang",ls_lang)

  LET ls_curr_date = "N/A"
  LET ls_prev_date = "N/A"

  FOR li_loop = 1 TO lo_web_alter_table_list.getLength()
    LET ls_curr_date = lo_web_alter_table_list[li_loop].tbl_DATE
    IF ls_prev_date <> ls_curr_date THEN
      LET ls_prev_date = ls_curr_date  
      LET lo_xml_domnode = lo_xml_elements.createChild("tables")
      CALL lo_xml_domnode.setAttribute("date",lo_web_alter_table_list[li_loop].tbl_DATE)
    END IF   

    #呼叫產出子節點
    CALL sadzi140_xml_gen_web_alter_table_info(lo_web_alter_table_list[li_loop].*,lo_xml_domnode)
    
  END FOR  

  #CALL lo_xml_elements.writeXml(ls_xml_filename)

  LET ls_xml_contents = lo_xml_elements.toString()
  CALL sadzi140_xml_write_file(ls_xml_filename, ls_xml_contents) RETURNING lb_result

  LET lb_return = lb_result

  RETURN lb_return  
  
END FUNCTION

FUNCTION sadzi140_xml_gen_web_alter_table_info(p_web_alter_table_list,p_xml_domnode)
DEFINE
  p_web_alter_table_list T_WEB_ALTER_TABLE_LIST,
  p_xml_domnode          om.DomNode 
DEFINE
  lo_web_alter_table_list T_WEB_ALTER_TABLE_LIST,
  lo_xml_table_domnode    om.DomNode

  LET lo_web_alter_table_list.* = p_web_alter_table_list.*

  LET lo_xml_table_domnode = p_xml_domnode.createChild("table")

  CALL lo_xml_table_domnode.setAttribute("name",lo_web_alter_table_list.tbl_TABLE)
  CALL lo_xml_table_domnode.setAttribute("module",lo_web_alter_table_list.tbl_MODULE)
  CALL lo_xml_table_domnode.setAttribute("lang",lo_web_alter_table_list.tbl_LANG)
      
END FUNCTION


################################################################################

FUNCTION sadzi140_xml_gen_table_datas(p_table_name,p_module_name,p_lang)
DEFINE
  p_table_name  STRING,
  p_module_name STRING,
  p_lang        STRING
DEFINE
  ls_table_name      STRING,
  ls_module_name     STRING,
  ls_lang            STRING,
  ls_schema_sql      STRING,
  ls_top_module_name STRING,
  ls_top_env         STRING,
  ls_module_env      STRING,
  ls_separator       STRING,
  ls_table_list      STRING,
  ls_tbl_full_name   STRING,  
  ls_web_full_name   STRING,
  lb_result          BOOLEAN  
  
  LET ls_table_name  = p_table_name
  LET ls_module_name = p_module_name
  LET ls_lang        = p_lang

  LET ls_separator = os.Path.separator()
  
  LET ls_module_env = FGL_GETENV(ls_module_name)
  
  LET ls_top_module_name = cs_top_module_name
  LET ls_top_env = FGL_GETENV(ls_top_module_name)

  &ifndef DEBUG
    LET ls_table_list = ls_top_env,ls_separator,"com",ls_separator,"mta",ls_separator,ls_lang,ls_separator,"tables.xml"
    LET ls_tbl_full_name = ls_module_env,ls_separator,"dzx",ls_separator,"tbl",ls_separator,ls_lang,ls_separator,ls_table_name,".tbl"
    LET ls_web_full_name = ls_top_env,ls_separator,"www",ls_separator,"clitool",ls_separator,"designer",ls_separator,"tbl",ls_separator,ls_lang,ls_separator,ls_table_name,".tbl"
  &else
    LET ls_table_list = "c:\\temp\\tbl\\tables.xml"
    LET ls_tbl_full_name = "c:\\temp\\tbl\\",ls_lang,ls_separator,ls_table_name,".tbl"
    LET ls_web_full_name = "c:\\temp\\www\\tbl\\",ls_separator,ls_lang,ls_separator,ls_table_name,".tbl"
  &endif
  
  #CALL sadzi140_xml_gen_table_catalog(ls_table_list,ls_lang) RETURNING lb_result -- 2015.11.23 Mark
  CALL sadzi140_xml_regen_base_tables_data(ls_table_list,ls_lang,ls_table_name)
  CALL sadzi140_xml_update_widget_width()
  CALL sadzi140_xml_gen_table_describe(ls_table_name,ls_tbl_full_name,ls_lang) RETURNING lb_result
  
  #將產出的tbl檔複製一份到web上供更新
  CALL sadzi140_xml_copy_tbl_to_web_path(ls_tbl_full_name,ls_web_full_name) RETURNING lb_result

  #移除此功能回歸到 azzi090
  #CALL sadzi140_xml_gen_table_data_types_xml(ls_table_name,ls_top_env||ls_separator||"com"||ls_separator||"mta"||ls_separator||ls_lang||ls_separator||"datatypes.xml") RETURNING lb_result
  
END FUNCTION

FUNCTION sadzi140_xml_gen_web_table_datas(p_lang)
DEFINE
  p_lang        STRING
DEFINE
  ls_lang            STRING,
  ls_schema_sql      STRING,
  ls_top_module_name STRING,
  ls_top_env         STRING,
  ls_separator       STRING,
  ls_alter_table_xml STRING,
  lb_result          BOOLEAN
DEFINE
  lo_web_alter_table_list DYNAMIC ARRAY OF T_WEB_ALTER_TABLE_LIST
  
  LET ls_lang = p_lang

  LET ls_separator = os.Path.separator()
  
  LET ls_top_module_name = cs_top_module_name
  LET ls_top_env = FGL_GETENV(ls_top_module_name)

  &ifndef DEBUG
    LET ls_alter_table_xml = ls_top_env,ls_separator,"www",ls_separator,"clitool",ls_separator,"designer",ls_separator,"AlterTableList.xml" 
  &else
    LET ls_alter_table_xml = "c:\\temp\\www\\AlterTableList.xml" 
  &endif
  
  CALL sadzi140_xml_get_web_alter_table_list() RETURNING lo_web_alter_table_list
  CALL sadzi140_xml_gen_web_alter_table_xml(lo_web_alter_table_list,ls_alter_table_xml,ls_lang) RETURNING lb_result

END FUNCTION

FUNCTION sadzi140_xml_copy_tbl_to_web_path(p_source,p_dest)
DEFINE
  p_source STRING,
  p_dest   STRING
DEFINE
  ls_source STRING,
  ls_dest   STRING,
  lb_result BOOLEAN

  LET ls_source = p_source
  LET ls_dest = p_dest

  CALL os.path.copy(ls_source,ls_dest) RETURNING lb_result

  RETURN lb_result
  
END FUNCTION 

FUNCTION sadzi140_xml_get_table_head_info(p_table_name,p_lang)
DEFINE
  p_table_name STRING,
  p_lang       STRING
DEFINE
  ls_table_name STRING,
  ls_lang       STRING,
  ls_sql        STRING
DEFINE  
  lo_table_head_info T_TABLE_HEAD_INFO,
  lo_return          T_TABLE_HEAD_INFO

  LET ls_table_name = p_table_name
  LET ls_lang       = p_lang

  INITIALIZE lo_table_head_info.* TO NULL
  INITIALIZE lo_return.* TO NULL

  LET ls_sql = "SELECT EA.DZEA003,EAL.DZEAL003,EA.DZEA004                     ",
               "  FROM DZEA_T EA                                              ",
               "  LEFT OUTER JOIN DZEAL_T EAL ON EAL.DZEAL001 = EA.DZEA001    ",
               "                             AND EAL.DZEAL002 = '",ls_lang,"' ",
               " WHERE EA.DZEA001 = '",ls_table_name,"'                       ",
               " ORDER BY EA.DZEA003,EA.DZEA001                               "
               
  PREPARE lpre_get_table_head_info FROM ls_sql
  DECLARE lcur_get_table_head_info CURSOR FOR lpre_get_table_head_info

  OPEN lcur_get_table_head_info
  FETCH lcur_get_table_head_info INTO lo_table_head_info.*
  CLOSE lcur_get_table_head_info
  
  FREE lpre_get_table_head_info
  FREE lcur_get_table_head_info  

  LET lo_return.* = lo_table_head_info.*
  
  RETURN lo_return.*
  
END FUNCTION

FUNCTION sadzi140_xml_get_lang_type_list()
DEFINE
  lo_lang_arr  DYNAMIC ARRAY OF T_LANGUAGE_TYPE,
  li_count     INTEGER,
  ls_sql       STRING 
DEFINE
  lo_return DYNAMIC ARRAY OF T_LANGUAGE_TYPE

  LET ls_sql = "SELECT GZZY001    ", 
               "  FROM GZZY_T     ", 
               " ORDER BY GZZY001 "
               
  PREPARE lpre_get_lang_type_list FROM ls_sql
  DECLARE lcur_get_lang_type_list CURSOR FOR lpre_get_lang_type_list

  LET li_count = 1
  
  OPEN lcur_get_lang_type_list
  FOREACH lcur_get_lang_type_list INTO lo_lang_arr[li_count]  
    IF SQLCA.sqlcode THEN
      EXIT FOREACH
    END IF

    LET li_count = li_count + 1

  END FOREACH
  CLOSE lcur_get_lang_type_list

  FREE lcur_get_lang_type_list
  FREE lpre_get_lang_type_list
  
  CALL lo_lang_arr.deleteElement(li_count)
  
  LET lo_return = lo_lang_arr

  RETURN lo_return
  
END FUNCTION 


FUNCTION sadzi140_xml_update_widget_width()
DEFINE
  ls_exec_sql STRING

  BEGIN WORK

  #Width
  LET ls_exec_sql = " UPDATE DZEP_T EP                                     ",
                    "    SET EP.DZEP009 = (                                ",
                    "                       SELECT TD.GZTD010              ",
                    "                         FROM GZTD_T TD,              ",
                    "                              DZEB_T EB               ",
                    "                        WHERE TD.GZTD001 = EB.DZEB006 ",
                    "                          AND EB.DZEB001 = EP.DZEP001 ",
                    "                          AND EB.DZEB002 = EP.DZEP002 ",
                    "                     )                                ", 
                    "  WHERE EP.DZEP009 IS NULL                            "
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)

  #Widget
  LET ls_exec_sql = " UPDATE DZEP_T EP                                     ",
                    "    SET EP.DZEP010 = (                                ",
                    "                       SELECT TD.GZTD005              ",
                    "                         FROM GZTD_T TD,              ",
                    "                              DZEB_T EB               ",
                    "                        WHERE TD.GZTD001 = EB.DZEB006 ",
                    "                          AND EB.DZEB001 = EP.DZEP001 ",
                    "                          AND EB.DZEB002 = EP.DZEP002 ",
                    "                     )                                ",
                    "  WHERE EP.DZEP010 IS NULL                            " 
                    
  CALL sadzi140_db_exec_SQL_no_commit(ls_exec_sql,FALSE)

  COMMIT WORK
  
END FUNCTION 

FUNCTION sadzi140_xml_write_file(p_FileName,p_LineString)
DEFINE
  p_FileName   STRING,
  p_LineString STRING
DEFINE   
  ls_file_name      STRING,
  ls_LineString     STRING,
  lo_channel_write  base.Channel,
  lb_success        BOOLEAN

  LET ls_file_name  = p_FileName
  LET ls_LineString = p_LineString

  LET lb_success = TRUE
  
  LET  lo_channel_write = base.Channel.create()
  CALL lo_channel_write.setDelimiter("")

  TRY
    CALL lo_channel_write.openFile(ls_file_name, "w" )
    CALL lo_channel_write.write(ls_LineString)
    CALL lo_channel_write.close()
    DISPLAY cs_success_tag,"XML '",ls_file_name,"' generate successed !!"
  CATCH
    LET lb_success = FALSE
    DISPLAY cs_error_tag,"XML '",ls_file_name,"' generate failed !!"
  END TRY  

  RETURN lb_success
  
END FUNCTION