#adzp152 副程式 - 狀態碼切換相關處理

IMPORT os
SCHEMA ds

GLOBALS
   DEFINE g_properties   om.SaxAttributes
   CONSTANT li_space = 3
END GLOBALS 

#+ create 狀態碼相關段落
PUBLIC FUNCTION adzp152_create_stus()
   DEFINE ls_stus STRING
   
   #確定有stus欄位
   LET ls_stus = g_properties.getValue("detail_stus_isExist")
   IF cl_null(ls_stus) OR ls_stus = "N" THEN
      CALL g_properties.addAttribute("general_mark_stus2","#") 
   END IF 
   
   #確定有stus欄位
   LET ls_stus = g_properties.getValue("master_stus_isExist")
   IF cl_null(ls_stus) OR ls_stus = "N" THEN
      CALL g_properties.addAttribute("general_mark_stus","#") 
      RETURN
   END IF 
   
   #a21子樣板讀取&產生
   CALL adzp152_state_show()
   
   #a24子樣板讀取&產生
   CALL adzp152_browser_state_show()

END FUNCTION

#+ 產生狀態碼action控制段落
PRIVATE FUNCTION adzp152_state_control()

   #CALL g_properties.addAttribute("general_state_control",adzp152_make_slice("a20"))

END FUNCTION

#+ 產生狀態碼圖片顯示段落
PRIVATE FUNCTION adzp152_state_show()

   CALL g_properties.addAttribute("general_state_show",adzp152_read_stus("a21"))

END FUNCTION

#+ 產生Browser狀態碼圖片顯示段落
PRIVATE FUNCTION adzp152_browser_state_show()

   CALL g_properties.addAttribute("browser_state_define",adzp152_read_stus("a24"))

END FUNCTION

#+ 生成stus元件
PUBLIC FUNCTION adzp152_read_stus(ps_template)
   DEFINE ps_template   STRING
   DEFINE ls_return     STRING 
   DEFINE lchannel_read base.Channel
   DEFINE ls_mdl        STRING
   DEFINE ls_read       STRING
   DEFINE ls_text       STRING
   DEFINE li_cnt        INTEGER
   DEFINE li_idx        INTEGER
   DEFINE ls_name       STRING
   DEFINE ls_value      STRING
   DEFINE ls_mdlpath    STRING


   #先讀取T100TEMPLATEPATH, 若無則採用$ERP/mdl
   LET ls_mdlpath = FGL_GETENV("T100TEMPLATEPATH")
   IF cl_null(ls_mdlpath) THEN
      LET ls_mdlpath = FGL_GETENV("ERP")
      LET ls_mdlpath = os.Path.join(ls_mdlpath,"mdl")
   END IF

   #定義取用樣板檔案
   LET ls_mdl = "slice/code_",ps_template,".template"
#  LET ls_mdl = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"mdl"),ls_mdl)
   LET ls_mdl = os.Path.join(ls_mdlpath,ls_mdl)

   #定義狀態資訊(mdl_stus,mdl_pic)
   LET li_cnt = g_properties.getValue("general_stus_cnt")
   FOR li_idx = 1 TO li_cnt
      LET ls_name  = "general_stus_type",li_idx USING "<<<"
      LET ls_value = g_properties.getValue(ls_name)
      LET ls_name  = "mdl_stus",li_idx USING "<<<"
      CALL g_properties.addAttribute(ls_name,ls_value)
      LET ls_name  = "general_stus_pic",li_idx USING "<<<"
      LET ls_value = g_properties.getValue(ls_name)
      LET ls_name  = "mdl_pic",li_idx USING "<<<"
      CALL g_properties.addAttribute(ls_name,ls_value)
   END FOR
   
   #開啟樣板檔
   LET lchannel_read = base.Channel.create()
   CALL lchannel_read.setDelimiter("")

   CALL lchannel_read.openFile( ls_mdl CLIPPED, "r" )
   
   WHILE NOT lchannel_read.isEof()
   
      LET ls_text = ""
      LET ls_read = lchannel_read.readLine()
    
      CASE
         WHEN ls_read.getIndexOf("#stus - Start -",1) 
            CALL adzp152_make_stus(lchannel_read) RETURNING ls_read,lchannel_read
         WHEN ls_read.getIndexOf("#master_keys - Start -",1) 
            CALL adzp152_make_keys_in_stus(lchannel_read,'m') RETURNING ls_read,lchannel_read
         WHEN ls_read.getIndexOf("#detail_keys - Start -",1) 
            CALL adzp152_make_keys_in_stus(lchannel_read,'d') RETURNING ls_read,lchannel_read
      END CASE

      #行代換/ 對 ${} 置換
      IF ls_read.getIndexOf("${",1) AND 
         ( ls_read.getIndexOf("${",1) < ls_read.getIndexOf("}",1) ) THEN
         LET ls_text = adzp152_line_replace(ls_read)
      ELSE
         LET ls_text = ls_read
      END IF
      
      LET ls_return = ls_return, ls_text, '\n'
      
   END WHILE  
   
   CALL lchannel_read.close()

   RETURN ls_return

END FUNCTION 

#stus產生
PUBLIC FUNCTION adzp152_make_stus(ps_read)
   DEFINE ps_read       base.Channel
   DEFINE ls_stus       DYNAMIC ARRAY OF STRING 
   DEFINE li_stus_num   LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE ls_is         STRING 
   DEFINE ls_return     STRING
   DEFINE ls_tmp        STRING
   
   #先取出stus段落之樣版
   WHILE TRUE 
      LET ls_tmp = ps_read.readLine()
      IF ls_tmp.getIndexOf("#stus -  End  -",1) THEN
         EXIT WHILE 
      END IF
      LET ls_stus[1] = ls_stus[1], ls_tmp, '\n'
   END WHILE 
   
   #總數量
   LET li_stus_num = g_properties.getValue("general_stus_cnt")
   
   #根據stus數量產生對應的stus段落並進行資料取代
   FOR li_cnt = 2 TO li_stus_num
      
      #先將${stus}取代掉
      LET ls_is = li_cnt
      LET ls_stus[li_cnt] = adzp152_replace_stus(ls_stus[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE ls_stus[li_cnt].getIndexOf("${",1) > 0 
         LET ls_stus[li_cnt] = adzp152_line_replace(ls_stus[li_cnt])
      END WHILE  
      LET ls_return = ls_return, ls_stus[li_cnt], '\n'
      
   END FOR    
   
   RETURN ls_return, ps_read
   
END FUNCTION 

#將${stus}取代為號碼
PUBLIC FUNCTION adzp152_replace_stus(ps_stus, pi_i)
   DEFINE ps_stus   STRING 
   DEFINE pi_i      STRING 
   DEFINE li_s      LIKE type_t.num5 
   DEFINE li_e      LIKE type_t.num5 
   DEFINE ls_stus   STRING 

   WHILE TRUE 
      LET li_s = ps_stus.getIndexOf("${stus}",1) - 1
      LET li_e = ps_stus.getLength()
      #取代${stus}
      LET ls_stus = ps_stus.subString(1,li_s), pi_i, ps_stus.subString((li_s+8),li_e)
      LET ps_stus = ls_stus
      IF ls_stus.getIndexOf("${stus}",1) < 1 THEN 
         EXIT WHILE
      END IF 
   END WHILE 
    
   RETURN ls_stus
   
END FUNCTION 

#+ 根據tabx設定之key數量產生對應之key段落
PRIVATE FUNCTION adzp152_make_keys_in_stus(l_read,l_type)
   DEFINE l_read        base.Channel
   DEFINE l_type        STRING 
   DEFINE l_tmp         STRING 
   DEFINE l_key         DYNAMIC ARRAY OF STRING 
   DEFINE l_key_num     LIKE type_t.num5 
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE l_is          STRING 
   DEFINE ls_return     STRING
   
   #先取出key段落之樣本
   WHILE TRUE 
      LET l_tmp = l_read.readLine()
      IF l_tmp.getIndexOf("#keys -  End  -",1) THEN
          EXIT WHILE 
      END IF
      LET l_key[1] = l_key[1],l_tmp , "\n"
   END WHILE 

   #取得key總數量
   IF l_type = 'm' THEN
      LET l_key_num = g_properties.getValue("master_pk_num")
   ELSE
      LET l_key_num = g_properties.getValue("detail_pk_num")
   END IF

   #根據key數量產生對應的key段落並進行資料取代
   FOR li_cnt = 2 TO l_key_num
      
      #先將${key}取代掉
      LET l_is = li_cnt
      LET ls_return = ls_return, (2*li_space) SPACES, "#key",l_is,"\n",
                      adzp152_replace_key(l_key[1],li_cnt)
                        
      #若資料未取代完成則重複返回
      WHILE ls_return.getIndexOf("${",1) > 0 
         LET ls_return = adzp152_line_replace(ls_return)
      END WHILE  
      
   END FOR  
   
   RETURN ls_return,l_read
   
END FUNCTION 




