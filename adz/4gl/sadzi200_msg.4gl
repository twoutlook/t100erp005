&include "../4gl/sadzi200_mcr.inc" 

IMPORT os
IMPORT util
IMPORT FGL fgldialog

SCHEMA ds

&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp310_type.inc"
&include "../4gl/sadzi200_type.inc"

&include "../4gl/sadzp000_cnst.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzp310_cnst.inc"
&include "../4gl/sadzi200_cnst.inc"

GLOBALS "../../cfg/top_global.inc"

FUNCTION sadzi200_msg_message_box(p_title,p_style,p_commant,p_image)
DEFINE
  p_title   STRING,
  p_style   STRING,
  p_commant STRING,
  p_image   STRING
  
  MENU p_title ATTRIBUTE (STYLE=p_style, COMMENT=p_commant.trim() CLIPPED, IMAGE=p_image)
    ON ACTION ok
      EXIT MENU
  END MENU
  
END FUNCTION

FUNCTION sadzi200_msg_question_box(p_title,p_style,p_commant,p_image)
DEFINE
  p_title   STRING,
  p_style   STRING,
  p_commant STRING,
  p_image   STRING
DEFINE
  ls_result  STRING
DEFINE
  ls_return  STRING  

  MENU p_title ATTRIBUTE (STYLE=p_style, COMMENT=p_commant.trim(), IMAGE=p_image)
    ON ACTION yes
      LET ls_result = cs_response_yes
      EXIT MENU
    ON ACTION no
      LET ls_result = cs_response_no
      EXIT MENU
    ON ACTION cancel
      LET ls_result = cs_response_cancel
      EXIT MENU
  END MENU
   
  LET ls_return = ls_result

  RETURN ls_return
  
END FUNCTION