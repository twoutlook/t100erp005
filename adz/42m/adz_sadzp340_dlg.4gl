&include "../4gl/sadzp340_mcr.inc" 

# Property of Four Js*
# (c) Copyright Four Js 1995, 2014. All Rights Reserved.
# * Trademark of Four Js Development Tools Europe Ltd
#   in the United States and elsewhere
# 
# Four Js and its suppliers do not warrant or guarantee that these
# samples are accurate and suitable for your purposes. Their inclusion is
# purely for information purposes only.

IMPORT os

#+ File open/save dialog box
#+ Provided in the utility library.
#+

PRIVATE DEFINE dirlist DYNAMIC ARRAY OF RECORD
                    name STRING,
                    parent, abspath STRING,
                    children BOOLEAN,
                    expanded BOOLEAN
                END RECORD

PRIVATE DEFINE filelist DYNAMIC ARRAY OF RECORD
                    eimage STRING, -- Used to detect the type!!!
                    entry STRING, -- Filename or Dirname
                    esize STRING,
                    emodt STRING,
                    etype STRING -- "Directory" or "*.xxx File"
                END RECORD

PRIVATE DEFINE last_opendlg_directory STRING
PRIVATE DEFINE last_savedlg_directory STRING

DEFINE fgl_winDialogDirection STRING

PRIVATE FUNCTION sadzp340_dlg_file_has_option(opt,optionlist)
  DEFINE opt, optionlist STRING
  DEFINE tok base.StringTokenizer
  LET tok = base.StringTokenizer.create(optionlist,",")
  WHILE tok.hasMoreTokens()
    IF tok.nextToken() == opt THEN RETURN TRUE END IF
  END WHILE
  RETURN FALSE
END FUNCTION

#+ Opens a file dialog to open a file.
#+ @returnType String
#+ @return The selected file path, or NULL is canceled.
#+ @param title The title of the file dialog
#+ @param defaultpath Default path to be selected
#+ @param defaultfile Default file to be displayed
#+ @param typelist Pipe separated list of extensions (*|*.*|*.4gl|*.ext|DIR)
#+ @param options Comma separated list of options (see below)
#
#+ Use DIR in the typelist to select a directory instead of a file.
#
#+ options is a comma separated list of options:
#     cd = can create directory
#     dd = can delete directory
#     df = can delete file
#     sh = can hide/show .* files
#     oe = confirm overwrite

PUBLIC FUNCTION sadzp340_dlg_opendlg(title,defaultpath,defaultfile,typelist,options)
  DEFINE title STRING
  DEFINE defaultpath STRING
  DEFINE defaultfile STRING
  DEFINE typelist STRING
  DEFINE options STRING
  DEFINE t, fn STRING
  IF defaultpath IS NULL THEN
     IF last_opendlg_directory IS NULL THEN
        LET last_opendlg_directory = os.Path.homedir()
     END IF
     LET defaultpath = last_opendlg_directory
  END IF
  IF title IS NOT NULL THEN
     LET t = title
  ELSE
     IF typelist = "DIR" THEN
        LET t = "Open directory"
     ELSE
        LET t = "Open file"
     END IF
  END IF
  LET fn = sadzp340_dlg_file_pathdlg("open",t,defaultpath,defaultfile,typelist,options)
  IF fn IS NOT NULL THEN
     LET last_opendlg_directory = os.Path.dirname(fn)
  END IF
  RETURN fn
END FUNCTION

#+ Opens a file dialog to save a file.
#+ @returnType String
#+ @return The selected file path, or NULL is canceled.
#+ @param title The title of the file dialog
#+ @param defaultpath Default path to be selected
#+ @param defaultfile Default file to be displayed
#+ @param typelist Pipe separated list of extensions (*|*.*|*.4gl|*.ext|DIR)
#+ @param options Comma separated list of options (see below)
#
#+ options is a comma separated list of options:
#     cd = can create directory
#     dd = can delete directory
#     df = can delete file
#     sh = can hide/show .* files
#     oe = confirm overwrite

PUBLIC FUNCTION sadzp340_dlg_savedlg(title,defaultpath,defaultfile,typelist,options)
  DEFINE title STRING
  DEFINE defaultpath STRING
  DEFINE defaultfile STRING
  DEFINE typelist STRING
  DEFINE options STRING
  DEFINE t, fn STRING

  IF defaultpath IS NULL THEN
     IF last_savedlg_directory IS NULL THEN
        LET last_savedlg_directory = os.Path.homedir()
     END IF
     LET defaultpath = last_savedlg_directory
  END IF
  IF title IS NOT NULL THEN
     LET t = title
  ELSE
     LET t = "Save file"
  END IF
  LET fn = sadzp340_dlg_file_pathdlg("save",t,defaultpath,defaultfile,typelist,options)
  IF fn IS NOT NULL THEN
     LET last_savedlg_directory = os.Path.dirname(fn)
  END IF
  RETURN fn
END FUNCTION

--------------------------------------------------------------------------------

PRIVATE FUNCTION sadzp340_dlg_file_pathdlg_setup(d,dlgtype,currpath,filename,typelist,options)
  DEFINE d ui.DIALOG
  DEFINE dlgtype, currpath, filename, typelist, options STRING
  DEFINE cr, isFolder, isValid, isFile INTEGER
  DEFINE filepath STRING
  DEFINE f ui.Form

  IF filelist.getLength()>0 THEN
     LET cr = d.getCurrentRow("sr2")
     IF dlgtype=="open" THEN
        LET filepath = os.Path.join(currpath,filelist[cr].entry)
     ELSE
        LET filepath = os.Path.join(currpath,filename)
     END IF
     LET isFolder = (filelist[cr].eimage == "folder" AND filelist[cr].entry != "..")
     LET isFile = (filelist[cr].eimage != "folder")
     LET isValid = sadzp340_dlg_file_checktypeandext(typelist,filepath)
  ELSE
     LET cr = 0
     LET filepath = NULL
     LET isFolder = FALSE
     LET isValid = FALSE
  END IF

  CALL d.setActionActive("btn_opensave", isValid)
  CALL d.setActionActive("create_dir",  sadzp340_dlg_file_has_option("cd",options))
  CALL d.setActionActive("delete_dir",  sadzp340_dlg_file_has_option("dd",options) AND isFolder)
  CALL d.setActionActive("delete_file", sadzp340_dlg_file_has_option("df",options) AND isFile)

  LET f = d.getForm()

  CALL f.setElementHidden("create_dir",  NOT sadzp340_dlg_file_has_option("cd",options))
  CALL f.setElementHidden("delete_dir",  NOT sadzp340_dlg_file_has_option("dd",options))
  CALL f.setElementHidden("delete_file", NOT sadzp340_dlg_file_has_option("df",options))

END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_lookup_entry(d, filename)
  DEFINE d ui.Dialog
  DEFINE filename STRING
  DEFINE i INTEGER
  FOR i=1 TO filelist.getLength()
      IF filelist[i].entry == filename THEN
         CALL d.setCurrentRow("sr2",i)
      END IF
  END FOR
END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_showdir(d, currpath, typelist, showhidden)
  DEFINE d ui.Dialog
  DEFINE currpath, typelist STRING
  DEFINE showhidden BOOLEAN
  DEFINE cur, cnt INT
  LET cur = sadzp340_dlg_file_initdirs(currpath)
  IF cur <= 0 THEN RETURN FALSE END IF
  CALL d.setCurrentRow("sr1",cur)
  LET cnt = sadzp340_dlg_file_getfiles(currpath,typelist,showhidden)
  CALL d.setCurrentRow("sr2",1)
  RETURN TRUE
END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_pathdlg(dlgtype,title,defaultpath,defaultfile,typelist,options)
  DEFINE dlgtype STRING
  DEFINE title STRING
  DEFINE defaultpath STRING
  DEFINE defaultfile STRING
  DEFINE typelist STRING
  DEFINE options STRING
  DEFINE filepath STRING
  DEFINE cur,cnt,cr INTEGER
  DEFINE currpath STRING
  DEFINE filename STRING
  DEFINE showhidden BOOLEAN
  DEFINE dirname CHAR(40)
  DEFINE tmpstr STRING
  DEFINE w ui.Window
  DEFINE f ui.Form
  DEFINE x INT, r BOOLEAN

  &ifndef DEBUG
    OPEN WINDOW w_sadzp340_dlg WITH FORM cl_ap_formpath("ADZ","sadzp340_dlg") ATTRIBUTES(STYLE='dialog3',TEXT=title)
    CALL cl_load_4ad_interface(NULL)
  &else
    OPEN WINDOW w_sadzp340_dlg WITH FORM "sadzp340_dlg" ATTRIBUTES(STYLE='dialog3',TEXT=title)
  &endif

  LET w = ui.Window.getCurrent()
  LET f = w.getForm()

  CALL f.setElementHidden("gfn",(dlgtype=="open"))
  CALL f.setElementText("gfn","Filename ("||typelist||")")
  
  CALL f.setElementText("btn_cancel","Cancel")
  IF dlgtype=="open" THEN
     CALL f.setElementText("btn_opensave","Open")
  ELSE
     CALL f.setElementText("btn_opensave","Save")
  END IF
  
  CALL f.setFieldHidden("showhidden", NOT sadzp340_dlg_file_has_option("sh",options))

  LET currpath = defaultpath
  LET filename = defaultfile
  LET showhidden = sadzp340_dlg_file_has_option("sh",options)

  LET cur = sadzp340_dlg_file_initdirs(currpath)
  IF cur <= 0 THEN RETURN NULL END IF
  LET currpath = dirlist[cur].abspath
  LET cnt = sadzp340_dlg_file_getfiles(currpath,typelist,showhidden)

  CALL ui.Dialog.setDefaultUnbuffered(TRUE)

  DIALOG ATTRIBUTES(UNBUFFERED, FIELD ORDER FORM)

    INPUT BY NAME currpath, filename, showhidden ATTRIBUTES(WITHOUT DEFAULTS)

       AFTER FIELD currpath
          IF DIALOG.getFieldTouched("currpath") THEN
             IF NOT sadzp340_dlg_file_showdir(DIALOG,currpath,typelist,showhidden) THEN
                CALL sadzp340_dlg_file_mbox_ok(title, "You must enter a valid directory name", "stop")
                NEXT FIELD currpath
             END IF
          END IF
          CALL DIALOG.setFieldTouched("currpath",FALSE)
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)

       AFTER FIELD filename
          IF filename IS NOT NULL AND filename!=""
             AND NOT sadzp340_dlg_file_checktypeandext(typelist,filename) THEN
             CALL sadzp340_dlg_file_mbox_ok(title,
                              "You must enter a valid file name",
                              "stop")
             NEXT FIELD filename
          END IF

       ON CHANGE showhidden
          LET x = sadzp340_dlg_file_showdir(DIALOG,currpath,typelist,showhidden)
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)

    END INPUT

    DISPLAY ARRAY dirlist TO sr1.*
       BEFORE ROW 
          LET cr = DIALOG.getCurrentRow("sr1")
          LET currpath = dirlist[cr].abspath
          LET cnt = sadzp340_dlg_file_getfiles(currpath,typelist,showhidden)
          CALL DIALOG.setCurrentRow("sr2",1)
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)
       ON EXPAND (x)
          LET r = sadzp340_dlg_file_getdirs(x)
          LET currpath = dirlist[x].abspath
          LET cnt = sadzp340_dlg_file_getfiles(currpath,typelist,showhidden)
          CALL DIALOG.setCurrentRow("sr2",1)
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)
       ON COLLAPSE (x)
          CALL sadzp340_dlg_file_deldirs(x)
          LET currpath = dirlist[x].abspath
          LET cnt = sadzp340_dlg_file_getfiles(currpath,typelist,showhidden)
          CALL DIALOG.setCurrentRow("sr2",1)
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)
    END DISPLAY

    DISPLAY ARRAY filelist TO sr2.*
       BEFORE ROW 
          LET cr = DIALOG.getCurrentRow("sr2")
          LET tmpstr = os.Path.join(currpath,filelist[cr].entry)
          IF sadzp340_dlg_file_checktypeandext(typelist,tmpstr) THEN
             LET filename = filelist[cr].entry
          END IF
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)
    END DISPLAY

    BEFORE DIALOG
       CALL DIALOG.setCurrentRow("sr1", cur)
       CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)

    ON ACTION create_dir
       LET dirname = sadzp340_dlg_prompt(title,
                                 "To create the new directory, enter the directory name",
                                 "Directory name:",
                                 NULL,NULL)
       IF dirname IS NOT NULL THEN
          LET tmpstr = os.Path.join(currpath,dirname CLIPPED)
          IF os.Path.mkdir(tmpstr) THEN
             LET currpath = tmpstr
             LET x = sadzp340_dlg_file_showdir(DIALOG,currpath,typelist,showhidden)
             --CALL sadzp340_dlg_file_lookup_entry(DIALOG, dirname)
          ELSE
             CALL sadzp340_dlg_file_mbox_ok(title, "The directory could not be created", "stop")
          END IF
       END IF

    ON ACTION delete_dir
       LET cr = DIALOG.getCurrentRow("sr2")
       LET filepath = os.Path.join(currpath,filelist[cr].entry)
       IF os.Path.type(filepath) != "directory" OR filelist[cr].entry == ".." THEN
          CONTINUE DIALOG
       END IF
       LET tmpstr = SFMT("Are you sure you want to delete directory (%1)",filelist[cr].entry)
       IF NOT sadzp340_dlg_file_mbox_yn(title, tmpstr, "question") THEN
          CONTINUE DIALOG
       END IF
       IF os.Path.delete(filepath) THEN
          LET cr = DIALOG.getCurrentRow("sr2")
          LET cnt = sadzp340_dlg_file_getfiles(currpath,typelist,showhidden)
          IF cr>cnt THEN CALL DIALOG.setCurrentRow("sr2",cnt) END IF
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)
       ELSE
          CALL sadzp340_dlg_file_mbox_ok(title, "The directory could not be deleted", "stop")
       END IF

    ON ACTION delete_file
       LET cr = DIALOG.getCurrentRow("sr2")
       LET filepath = os.Path.join(currpath,filelist[cr].entry)
       IF os.Path.type(filepath) == "directory" THEN
          CONTINUE DIALOG
       END IF
       LET tmpstr = SFMT("Are you sure you want to remove file (%1)?",filelist[cr].entry)
       IF NOT sadzp340_dlg_file_mbox_yn(title, tmpstr, "question") THEN
          CONTINUE DIALOG
       END IF
       IF os.Path.delete(filepath) THEN
          LET cr = DIALOG.getCurrentRow("sr2")
          LET cnt = sadzp340_dlg_file_getfiles(currpath,typelist,showhidden)
          IF DIALOG.getCurrentRow("sr2") > cnt THEN
             CALL DIALOG.setCurrentRow("sr2",cnt)
          END IF
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)
       ELSE
          CALL sadzp340_dlg_file_mbox_ok(title, "The file could not be deleted", "stop")
       END IF

    ON ACTION accept
       -- Enter in path field
       IF INFIELD(currpath) THEN
          IF NOT sadzp340_dlg_file_showdir(DIALOG,currpath,typelist,showhidden) THEN
             CALL sadzp340_dlg_file_mbox_ok(title, "You must enter a valid directory name", "stop")
             NEXT FIELD currpath
          END IF
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)
          CONTINUE DIALOG
       END IF
       -- Enter in filename field
       IF INFIELD(filename) THEN
          IF filename IS NULL OR filename=="" THEN
             CONTINUE DIALOG
          END IF
          IF NOT sadzp340_dlg_file_checktypeandext(typelist,filename) THEN
             CALL sadzp340_dlg_file_mbox_ok(title, "Invalid file name specified", "stop")
             NEXT FIELD filename
          ELSE
             LET filepath = sadzp340_dlg_file_check_selection(DIALOG, dlgtype, title, currpath, filename, typelist, options)
             IF filepath IS NULL THEN CONTINUE DIALOG ELSE EXIT DIALOG END IF
          END IF
       END IF

    ON ACTION select
       LET cr = DIALOG.getCurrentRow("sr2")
       IF filelist[cr].eimage = "folder" THEN
          IF filelist[cr].entry = ".." THEN
             LET currpath = os.Path.dirname(currpath)
          ELSE
             LET currpath = os.Path.join(currpath,filelist[cr].entry)
          END IF
          LET x = sadzp340_dlg_file_showdir(DIALOG,currpath,typelist,showhidden)
          CALL sadzp340_dlg_file_pathdlg_setup(DIALOG,dlgtype,currpath,filename,typelist,options)
       ELSE
          LET filepath = sadzp340_dlg_file_check_selection(DIALOG, dlgtype, title, currpath, filename, typelist, options)
          IF filepath IS NOT NULL THEN EXIT DIALOG END IF
       END IF

    ON ACTION btn_cancel
       LET filepath = NULL
       EXIT DIALOG
       
    ON ACTION btn_opensave
       LET filepath = sadzp340_dlg_file_check_selection(DIALOG, dlgtype, title, currpath, filename, typelist, options)
       IF filepath IS NOT NULL THEN EXIT DIALOG END IF

  END DIALOG

  CLOSE WINDOW w_sadzp340_dlg

  RETURN filepath
  
END FUNCTION

{
PRIVATE FUNCTION sadzp340_dlg_file_lookupdir(path)
  DEFINE path STRING
  DEFINE i INT
  FOR i=1 TO dirlist.getLength()
    IF dirlist[i].abspath = path THEN RETURN i END IF
  END FOR
  RETURN 0 
END FUNCTION
}

PRIVATE FUNCTION sadzp340_dlg_file_check_selection(d, dlgtype, title, currpath, filename, typelist, options)
  DEFINE d ui.Dialog
  DEFINE dlgtype, title, currpath, filename, typelist, options STRING
  DEFINE filepath STRING
  DEFINE cr INTEGER

  LET cr = d.getCurrentRow("sr2")
  IF cr == 0 THEN RETURN NULL END IF

  IF dlgtype=="open" THEN
     LET filepath = os.Path.join(currpath,filelist[cr].entry)
  ELSE
     LET filepath = os.Path.join(currpath,filename)
  END IF
  IF NOT sadzp340_dlg_file_checktypeandext(typelist,filepath) THEN
     CALL sadzp340_dlg_file_mbox_ok(title, SFMT("The selection must be one of (%1)",typelist), "stop")
     RETURN NULL
  END IF
  IF dlgtype=="save" THEN
     IF os.Path.exists(filepath) THEN
        IF sadzp340_dlg_file_has_option("oe",options) THEN
           IF NOT sadzp340_dlg_file_mbox_yn(title, "The selected file exists, do you want to overwrite it anyway?", "question") THEN
              RETURN NULL
           ELSE
              RETURN filepath
           END IF
        ELSE
           CALL sadzp340_dlg_file_mbox_ok(title, "You are not allowed to overwrite existing files", "stop")
           RETURN NULL
        END IF
     END IF
  END IF

  RETURN filepath

END FUNCTION
 
PRIVATE FUNCTION sadzp340_dlg_file_intypelist(typelist,type)
  DEFINE typelist STRING
  DEFINE type STRING
  DEFINE st base.StringTokenizer
  LET st = base.StringTokenizer.create(typelist,"|")
  WHILE st.hasMoreTokens()
    IF st.nextToken()==type THEN RETURN TRUE END IF
  END WHILE
  RETURN FALSE
END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_dirWithChildren(dirpath)
  DEFINE dirpath STRING
  DEFINE dh INTEGER
  DEFINE found BOOLEAN
  DEFINE fname, pname STRING
  LET dh = os.Path.diropen(dirpath)
  LET found = FALSE
  WHILE TRUE
      LET fname = os.Path.dirnext(dh)
      IF fname IS NULL THEN EXIT WHILE END IF
      IF fname == "." OR fname == ".." THEN
         CONTINUE WHILE
      END IF
      LET pname = os.Path.join(dirpath, fname)
      IF os.Path.type(pname) == "directory" THEN
         LET found = TRUE
         EXIT WHILE
      END IF
  END WHILE
  CALL os.Path.dirclose(dh)
  RETURN found
END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_initdirs(dirpath)
  DEFINE dirpath STRING
  DEFINE path STRING
  DEFINE arr DYNAMIC ARRAY OF STRING
  DEFINE i, x, c INT
  IF dirpath IS NULL THEN RETURN -1 END IF
  LET path = dirpath
  IF NOT os.Path.exists(path) THEN
     RETURN -2
  END IF
  IF os.Path.type(path) != "directory" THEN
     LET path = os.Path.dirname(path)
  END IF
  WHILE path IS NOT NULL
    CALL arr.insertElement(1)
    LET arr[1] = path
    LET path = os.Path.dirname(path)
    IF path = os.Path.dirname(path) THEN EXIT WHILE END IF
  END WHILE
  CALL dirlist.clear()
  LET path = arr[1]
  CALL dirlist.appendElement()
  IF fgl_getenv("WINDIR") THEN
     LET dirlist[1].name = path
  ELSE
     LET dirlist[1].name = os.Path.basename(path)
  END IF
  LET dirlist[1].parent = NULL
  LET dirlist[1].abspath = path
  LET dirlist[1].children = sadzp340_dlg_file_dirWithChildren(path)
  LET dirlist[1].expanded = TRUE
  LET x = 1
  FOR c = 1 TO arr.getLength() - 1
    LET dirlist[x].expanded = TRUE
    IF sadzp340_dlg_file_getdirs(x) <= 0 THEN EXIT FOR END IF
    FOR i = x TO dirlist.getLength()
      IF dirlist[i].abspath == arr[c+1] THEN LET x=i EXIT FOR END IF
    END FOR
  END FOR
  RETURN x
END FUNCTION

-- ON EXPAND
PRIVATE FUNCTION sadzp340_dlg_file_getdirs(index)
  DEFINE index INT
  DEFINE dh, cnt, pos INTEGER
  DEFINE dirpath, fname, pname STRING
  IF index<=0 OR dirlist.getLength()==0 THEN RETURN -2 END IF
  LET dirpath = dirlist[index].abspath
  LET dh = os.Path.diropen(dirpath)
  IF dh == 0 THEN RETURN -1 END IF
  LET cnt = 0
  WHILE TRUE
      LET fname = os.Path.dirnext(dh)
      IF fname IS NULL THEN EXIT WHILE END IF
      -- Skip current dir (.), parent dir (..), hidden files (.xx)
      IF fname.subString(1,1) == "." THEN
         CONTINUE WHILE
      END IF
      LET pname = os.Path.join(dirpath, fname)
      -- Skip regular files
      IF os.Path.type(pname) != "directory" THEN
         CONTINUE WHILE
      END IF
      LET cnt = cnt + 1
      LET pos = index + cnt 
      IF pos > dirlist.getLength() THEN
         CALL dirlist.appendElement()
      ELSE
         CALL dirlist.insertElement(pos)
      END IF
      LET dirlist[pos].name = fname
      LET dirlist[pos].parent = dirpath
      LET dirlist[pos].abspath = pname
      LET dirlist[pos].children = sadzp340_dlg_file_dirWithChildren(pname)
      LET dirlist[pos].expanded = FALSE
  END WHILE
  CALL os.Path.dirclose(dh)
  RETURN cnt
END FUNCTION

-- ON COLLAPSE
PRIVATE FUNCTION sadzp340_dlg_file_deldirs(index)
  DEFINE index INT
  DEFINE parent STRING
  LET parent = dirlist[index].abspath
  WHILE index < dirlist.getLength()
    IF dirlist[index+1].parent != parent THEN EXIT WHILE END IF
    CALL sadzp340_dlg_file_deldirs(index+1)
    CALL dirlist.deleteElement(index+1)
  END WHILE
END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_getfiles(dirpath,typelist,showhidden)
  DEFINE dirpath, typelist STRING, showhidden BOOLEAN
  DEFINE dh, ns INTEGER
  DEFINE fname, pname, size, type, image, ext STRING
  CALL filelist.clear()
  CALL os.Path.dirsort("extension",1) --too slow? by type it's very slow.
  LET dh = os.Path.diropen(dirpath)
  IF dh == 0 THEN RETURN -1 END IF
  WHILE TRUE
      LET fname = os.Path.dirnext(dh)
      IF fname IS NULL THEN EXIT WHILE END IF
      LET pname = os.Path.join(dirpath, fname)
      IF fname == "." THEN
         CONTINUE WHILE
      END IF
      IF NOT showhidden THEN
         IF fname.getCharAt(1) == "." AND fname.getCharAt(2) != "." THEN 
            CONTINUE WHILE
         END IF
      END IF
      IF os.Path.type(pname) != "directory"
         AND NOT sadzp340_dlg_file_checktypeandext(typelist,pname) THEN
            CONTINUE WHILE
      END IF
      LET ext = os.Path.extension(pname)
      CASE os.Path.type(pname)
           WHEN "directory"
                LET image = "folder"
                LET type = "Directory"
           WHEN "file"
                LET image = "file"
                IF ext.getLength()==0 THEN
                   LET ext = "???"
                ELSE
                   LET ext = ext.toUpperCase()
                END IF
                LET type = SFMT("%1 file",ext)
      END CASE
      IF os.Path.type(pname) != "file" THEN
         LET size = NULL
      ELSE
         LET ns = os.Path.size(pname)
         LET size = ns 
         IF ns>1024 THEN
            LET ns = ns/1024
            LET size = ns||" Kb"
            IF ns>1024 THEN
               LET ns = ns/1024
               LET size = ns||" Mb"
               IF ns>1024 THEN
                  LET ns = ns/1024
                  LET size = ns||" Gb"
               END IF
            END IF
         END IF
      END IF
      CALL filelist.appendElement()
      LET filelist[filelist.getLength()].entry = fname
      LET filelist[filelist.getLength()].etype = type
      LET filelist[filelist.getLength()].eimage = image
      LET filelist[filelist.getLength()].esize = size
      LET filelist[filelist.getLength()].emodt = os.Path.mtime(pname)
  END WHILE
  CALL os.Path.dirclose(dh)
  RETURN filelist.getLength()
END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_checktypeandext(typelist,fname)
  DEFINE typelist, fname STRING
  DEFINE e STRING
  IF os.Path.basename(fname)==".." THEN
     RETURN FALSE
  END IF
  IF sadzp340_dlg_file_intypelist(typelist,"*") THEN
     RETURN TRUE
  END IF
  IF sadzp340_dlg_file_intypelist(typelist,"DIR") AND os.Path.type(fname) == "directory" THEN
     RETURN TRUE
  END IF
  LET e = os.Path.extension(fname)
  IF e IS NOT NULL THEN
     IF sadzp340_dlg_file_intypelist(typelist,"*.*") THEN
        RETURN TRUE
     END IF
     IF sadzp340_dlg_file_intypelist(typelist,"*."||e) THEN
        RETURN TRUE
     END IF
  END IF
  RETURN FALSE
END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_mbox_ok(title,message,icon)
  DEFINE title, message, icon STRING
  CALL sadzp340_dlg_winMessage(title,message,icon)
END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_file_mbox_yn(title,message,icon)
  DEFINE title, message, icon STRING
  DEFINE r STRING
  LET r = sadzp340_dlg_winQuestion(title,message,"yes","yes|no",icon,0)
  RETURN ( r == "yes" )
END FUNCTION


#+ Is this 4gl program connected to a graphical user interface?
#+ @returnType Integer
#+ @return TRUE if connected to graphical user interface.
FUNCTION sadzp340_dlg_fglGui()
  DEFINE uiName String
  WHENEVER ERROR RAISE
  LET uiName=ui.Interface.getFrontEndName()
  IF uiName IS NOT NULL then
    IF NOT uiName.equals("Console") THEN
      RETURN 1
    END IF
  END IF
  WHENEVER ERROR STOP
  RETURN 0
END FUNCTION

#+ Opens window with message and choice.
#+ @returnType String
#+ @return The answer string.
#+ @param title Title of the window.
#+ @param message Message to be displayed.
#+ @param ans Default answer.
#+ @param items Pipe separated list of choices.
#+ @param icon Icon specification: 'info','exclamation','stop','question'.
#+ @param dang Danger indicator level ( 0, 1, 2, 3 ) - ignored.
#+
#+ The function returns one of the case-sensitive Strings in the items list.
#+ Displays a message with definable multiple choices.
FUNCTION sadzp340_dlg_winButton(title,message,ans,items,icon,dang)
  DEFINE title, message, ans, items, icon STRING
  DEFINE dang INTEGER -- unused ?
  DEFINE i, itemC INTEGER
  DEFINE result String
  DEFINE tokenizer base.StringTokenizer
  DEFINE itemV array[10] of STRING
  DEFINE styleToUse STRING
  DEFINE ansU STRING

  IF title IS NULL THEN LET title = "" END IF
  IF message IS NULL THEN LET message = "" END IF
  IF icon IS NULL THEN LET icon = "" END IF
  LET title=title.trimRight()
  LET message=message.trimRight()
  LET icon=icon.trimRight()

  LET tokenizer=base.StringTokenizer.create(items,"|")
  LET itemC=0
  WHILE tokenizer.hasMoreTokens() AND itemC<10 
    LET itemC=itemC+1
    LET itemV[itemC]=tokenizer.nextToken()
  END WHILE
  IF itemC = 0 THEN RETURN NULL END IF
  IF NOT sadzp340_dlg_fglGui() THEN RETURN NULL END IF
  IF icon="info" THEN
    LET icon="information"
  END IF
  IF  icon != "information" AND icon != "exclamation" AND icon != "stop"
    AND icon != "question"
  THEN
    LET icon = NULL
  END IF
  LET result = ans 
  FOR i = itemC+1 TO 10
    LET itemV[i]="sadzp340_dlg_winButton_item_No_"||i
  END FOR
  LET ansU=ans.toUpperCase()
  LET styleToUse = "dialog" , fgl_winDialogDirection 
  MENU title ATTRIBUTE(STYLE=styleToUse,COMMENT=message,IMAGE=icon)
    BEFORE MENU
      FOR i = itemC+1 TO 10
        HIDE OPTION itemV[i]
      END FOR
      FOR i=1 TO itemC
        IF upshift(itemV[i])=ansU THEN
          NEXT OPTION itemV[i]
          EXIT FOR
        END IF
      END FOR
    COMMAND itemV[1]
      LET result=itemV[1]
    COMMAND itemV[2]
      LET result=itemV[2]
    COMMAND itemV[3]
      LET result=itemV[3]
    COMMAND itemV[4]
      LET result=itemV[4]
    COMMAND itemV[5]
      LET result=itemV[5]
    COMMAND itemV[6]
      LET result=itemV[6]
    COMMAND itemV[7]
      LET result=itemV[7]
    COMMAND itemV[8]
      LET result=itemV[8]
    COMMAND itemV[9]
      LET result=itemV[9]
    COMMAND itemV[10]
      LET result=itemV[10]
  END MENU
  RETURN result
END FUNCTION

#+ Shows a window with message and OK button.
#+ @param title Title of the window.
#+ @param message Message to be displayed.
#+ @param icon Icon specification: 'info','exclamation','stop','question'.
FUNCTION sadzp340_dlg_winMessage(title,message,icon)
  DEFINE title String
  DEFINE message String
  DEFINE icon  String
  DEFINE ans CHAR(1)
  IF NOT sadzp340_dlg_fglGui() THEN
    IF LENGTH(message) THEN
      PROMPT message CLIPPED FOR CHAR ans
    ELSE
      PROMPT "" FOR CHAR ans
    END IF
    RETURN
  END IF
  IF icon="info" THEN
    LET icon="information"
  END IF
  IF  icon != "information"
    AND icon != "exclamation"
    AND icon != "stop"
    AND icon != "question"
  THEN
    LET icon = NULL
  END IF
  LET ans = sadzp340_dlg_winQuestion(title,message,1,"OK",icon,0)
END FUNCTION

#+ Prompts for data input.
#+ @returnType String
#+ @return NULL if error.
#+ @param line    Line.
#+ @param column  Column.
#+ @param message Message.
#+ @param ans     Default answer.
#+ @param width   Length of input field.
#+ @param type    Data type (0=CHAR,1=SMALLINT,2=INTEGER,7=DATE,255=HIDDEN).
FUNCTION sadzp340_dlg_winPrompt(line,column,message,ans,width,type)
  DEFINE line    INTEGER
  DEFINE column  INTEGER
  DEFINE message String
  DEFINE ans     String
  DEFINE width   INTEGER
  DEFINE type    INTEGER
  DEFINE
    lgtot     INTEGER,
    lgmess    INTEGER,
    newstr    CHAR(100),
    newint    INTEGER,
    newdate   DATE,
    newsma    SMALLINT,
    endinput  SMALLINT,
    disp      CHAR(512),
    errstatus SMALLINT
  IF  type != 0
  AND type != 1
  AND type != 2
  AND type != 7
  AND type != 255
  THEN
    ERROR "promptat: Unkwon type"
    RETURN NULL
  END IF
  LET lgmess = LENGTH(message)
  LET lgtot = LENGTH(message) + width
  LET endinput = FALSE
  WHILE NOT endinput
    WHENEVER ERROR CONTINUE
    CASE
      WHEN type = 0
        PROMPT message CLIPPED ATTRIBUTE(normal) FOR newstr
         ON KEY(ACCEPT)
           LET endinput = FALSE
        END PROMPT
      WHEN type = 1
        PROMPT message CLIPPED ATTRIBUTE(normal) FOR newsma
          ON KEY(ACCEPT)
            LET endinput = FALSE
        END PROMPT
      WHEN type = 2
        PROMPT message CLIPPED ATTRIBUTE(normal) FOR newint
          ON KEY(ACCEPT)
            LET endinput = FALSE
        END PROMPT
      WHEN type = 7
        PROMPT message CLIPPED ATTRIBUTE(normal) FOR newdate
          ON KEY(ACCEPT)
            LET endinput = FALSE
        END PROMPT
      WHEN type = 255
        PROMPT message CLIPPED ATTRIBUTE(normal) FOR newstr ATTRIBUTE(invisible)
          ON KEY(ACCEPT)
            LET endinput = FALSE
        END PROMPT
    END CASE
    LET errstatus = status
    WHENEVER ERROR STOP
    IF int_flag THEN
      LET endinput = TRUE
    ELSE
      IF errstatus < 0 THEN
        LET disp = err_get(errstatus)
        ERROR disp CLIPPED
      ELSE
        LET endinput = TRUE
      END IF
    END IF
  END WHILE
  CASE
    WHEN type = 0
      RETURN newstr
    WHEN type = 1
      RETURN newsma
    WHEN type = 2
      RETURN newint
    WHEN type = 7
      RETURN newdate
    WHEN type = 255
      RETURN newstr
  END CASE
  RETURN NULL
END FUNCTION

-- sadzp340_dlg_winQuestion
-- Displays a message with fixed choices 
-- 1) The function returns case-sensitive localized Strings!
-- 2) The client shows language specific Captions!

#+ Opens window with message and multiple choices.
#+ @returnType String
#+ @return Answer or NULL if error.
#+ @param title Title of the window.
#+ @param message Message to be displayed.
#+ @param ans Default answer.
#+ @param items Pipe separated list of : yes,no,ok,cancel,retry,abort,ignore.
#+ @param icon Icon specification: 'info','exclamation','stop','question'.
#+ @param dang Danger indicator level ( 0, 1, 2, 3 ) - ignored.
FUNCTION sadzp340_dlg_winQuestion(title,message,ans,items,icon,dang)
  DEFINE title,message,ans,items,icon String
  DEFINE dang Integer # ignored
  DEFINE result String
  DEFINE answerYes, answerNo, answerOk, answerAbort, answerRetry, answerIgnore, answerCancel String
  DEFINE item, uItem String
  DEFINE tokenizer base.StringTokenizer
  DEFINE styleToUse STRING

  IF title is NULL THEN LET title = "" END IF
  IF ans is NULL THEN LET ans = "" END IF
  IF message is NULL THEN LET message = "" END IF
  IF icon is NULL THEN LET icon = "" END IF
  LET icon=icon.trimRight()
  LET title=title.trimRight()
  LET message=message.trimRight()
  LET icon=icon.trimRight()

  IF icon="info" THEN
    LET icon="information"
  END IF
  IF icon!="information" AND icon!="exclamation" AND icon!="stop" 
    AND icon!="question" THEN
    LET icon = ""
  END IF
  LET ans=ans.toUpperCase()
  LET styleToUse = "winmsg" , fgl_winDialogDirection 
  MENU title attribute(style=styleToUse,comment=message,image=icon)
    BEFORE MENU
      HIDE OPTION ALL
      LET tokenizer=base.StringTokenizer.create(items,"|")
      IF NOT tokenizer.hasMoreTokens() THEN RETURN NULL END IF
      WHILE tokenizer.hasMoreTokens()
        LET item=tokenizer.nextToken()
        LET uItem = item.toUpperCase()
        CASE
        WHEN uitem = "JA" OR uitem = "OUI" OR uitem="YES"
          SHOW OPTION "yes" 
          LET answerYes=item
          IF ans==uitem then NEXT OPTION "yes" END IF
        WHEN uitem = "NO" OR uitem = "NEIN" OR uitem="NON"
          SHOW OPTION "no"
          LET answerNo=item
          IF ans==uItem then NEXT OPTION "no" END IF
        WHEN uItem = "OK"
          SHOW OPTION "ok"
          LET answerOk= item
          IF ans==uItem then NEXT OPTION "ok" END IF
        WHEN uitem="CANCEL" OR uitem="INTERROMPRE" OR uitem="UNTERBRECHEN" 
          OR uItem="INTERRUPT" OR uItem="ANNULER"
          SHOW OPTION "cancel"
          LET answerCancel=item
          IF ans==uItem THEN NEXT OPTION "cancel" END IF
        WHEN uitem="WIEDERHOLEN" OR uitem="REPETER" OR uitem="RETRY"
          SHOW OPTION "retry"
          LET answerRetry=item
          IF ans==uItem then NEXT OPTION "retry" END IF
        WHEN uitem="IGNORER" OR uitem="IGNORE"
          OR uitem="IGNORIEREN" OR uitem="UEBERGEHEN" OR uitem="_BERGEHEN"
          SHOW OPTION "ignore"
          LET answerIgnore=item
          IF ans==uItem THEN  NEXT OPTION "ignore" END IF
        WHEN uitem="ABANDON" OR uitem="ABORT" OR uitem="ABBRECHEN"
          SHOW OPTION "abort"
          let answerAbort=item
          IF ans==uItem THEN  NEXT OPTION "abort" END IF
        OTHERWISE
          ERROR "Bad option '",item,"' in function sadzp340_dlg_winQuestion"
          RETURN NULL
        END CASE
      END WHILE
    COMMAND "yes"
      LET result=answerYes
    COMMAND "no"
      LET result=answerNo
    COMMAND "ok"
      LET result=answerOk
    COMMAND "abort"
      LET result=answerAbort
    COMMAND "retry"
      LET result=answerRetry
    COMMAND "ignore"
      LET result=answerIgnore
    COMMAND "cancel"
      LET result=answerCancel
  END MENU
  RETURN result
END FUNCTION

#+ Display a message and wait for a key press.
#+ @param message Message to be displayed.
FUNCTION sadzp340_dlg_winWait(message)
  DEFINE message  String
  DEFINE l        SMALLINT
  DEFINE c        SMALLINT
  DEFINE win      SMALLINT
  DEFINE ans      CHAR(1)
  DEFINE lg       SMALLINT
  IF NOT sadzp340_dlg_fglGui() THEN
    LET lg = LENGTH(message)
    IF win AND l AND c AND lg THEN
      OPEN WINDOW w_wait AT l, c WITH 1 ROWS, lg COLUMNS ATTRIBUTE (BORDER)
      PROMPT message CLIPPED FOR CHAR ans
      CLOSE WINDOW w_wait
    ELSE
      IF lg>0 THEN
        PROMPT message CLIPPED FOR CHAR ans
      ELSE
        PROMPT "" FOR CHAR ans
      END IF
    END IF
    RETURN
  END IF
  LET ans = sadzp340_dlg_winQuestion("",message,1,"OK","",0)
END FUNCTION

#+ Checks UI client to be WTK.
#+ @returnType Integer
#+ @return TRUE if the UI is a WTK.
FUNCTION sadzp340_dlg_wtkClient()
  DEFINE uiName String
  LET uiName=ui.Interface.getFrontEndName()
  IF uiName IS NOT NULL then
    IF uiName.equals("Wtk") THEN
      RETURN 1
    END IF
  END IF
  RETURN 0
END FUNCTION

FUNCTION sadzp340_dlg_setWinDialogDirectionRightToLeft()
  LET fgl_winDialogDirection = " rightToLeft"
END FUNCTION

FUNCTION sadzp340_dlg_setWinDialogDirectionLeftToRight()
  LET fgl_winDialogDirection = " leftToRight"
END FUNCTION

-- fgl_fixedcomment

#+ Starts a wait dialog session.
#+ @param title The title of the window.
#+ The wait dialog box gets a 'interrupt' button that can be pressed by the
# user to interrupt the process.
PUBLIC FUNCTION sadzp340_dlg_wait_open(title)
  DEFINE title STRING
  OPEN WINDOW __fgltwait WITH FORM "fgltwait"
              ATTRIBUTES(STYLE="dialog2",TEXT=title)
END FUNCTION

#+ Shows the wait dialog box.
#+ @param comment The comment to be displayed.
PUBLIC FUNCTION sadzp340_dlg_wait_show(comment)
  DEFINE comment STRING
  CURRENT WINDOW IS __fgltwait
  DISPLAY BY NAME comment
  CALL ui.Interface.refresh()
END FUNCTION

#+ Terminates a wait dialog session.
PUBLIC FUNCTION sadzp340_dlg_wait_close()
  CLOSE WINDOW __fgltwait
END FUNCTION

--------------------------------------------------------------------------------

#+ Starts a progress dialog session.
#+ @param title The title of the progress window.
#+ @param comment The comment to be displayed in the progress window.
#+ @param vmin The minimum value for the progress bar.
#+ @param vmax The maximum value for the progress bar.
PUBLIC FUNCTION sadzp340_dlg_progress_open(title,comment,vmin,vmax)
  DEFINE title STRING
  DEFINE comment STRING
  DEFINE vmin, vmax INTEGER
  DEFINE w ui.Window
  DEFINE f ui.Form
  DEFINE p,n om.DomNode
  DEFINE nl om.NodeList

  OPEN WINDOW __fgltprogress WITH FORM "fgltprogress"
              ATTRIBUTES(style="dialog2",text=title)

  LET w = ui.Window.getCurrent()
  LET f = w.getForm()

  IF comment IS NULL THEN
     CALL f.setFieldHidden("comment", 1)
  ELSE
     DISPLAY BY NAME comment
  END IF

  LET p = w.getNode()
  LET nl = p.selectByPath("//ProgressBar")
  LET n = nl.item(1)
  CALL n.setAttribute("valueMin",vmin)
  CALL n.setAttribute("valueMax",vmax)

END FUNCTION

#+ Sets the progressbar value in a progress dialog session.
#+ @param progress The value to be set in the progressbar.
PUBLIC FUNCTION sadzp340_dlg_progress_show(progress)
  DEFINE progress INTEGER
  CURRENT WINDOW IS __fgltprogress
  DISPLAY BY NAME progress
  CALL ui.Interface.refresh()
END FUNCTION

#+ Terminates a progress session.
PUBLIC FUNCTION sadzp340_dlg_progress_close()
  CLOSE WINDOW __fgltprogress
END FUNCTION

--------------------------------------------------------------------------------

#+ Opens a database login dialog.
#+ @returnType Integer, String, String, String
#+ @return TRUE/FALSE, dbname, username and password
#+ @param title The title of the login dialog
#+ @param comment The comment to be displayed in the login dialog
#+ @param dbname Default value for the database source
#+ @param username Default value for the database user
#+ @param password Default value for the user password
PUBLIC FUNCTION sadzp340_dlg_dblogin(title,comment,dbname,username,password)
  DEFINE title, comment, dbname, username, password STRING
  DEFINE w ui.Window
  DEFINE f ui.Form

  OPEN WINDOW __fgldblogin WITH FORM "fgltlogin"
              ATTRIBUTES(STYLE="dialog",TEXT=title)

  LET w = ui.Window.getCurrent()
  LET f = w.getForm()

  IF dbname == "*" THEN
     CALL f.setElementHidden("label_dbname", 1)
     CALL f.setFieldHidden("dbname", 1)
  END IF
  IF comment IS NULL THEN
     CALL f.setFieldHidden("comment", 1)
  ELSE
     DISPLAY BY NAME comment
  END IF

  LET int_flag = FALSE
  INPUT BY NAME dbname, username, password
        WITHOUT DEFAULTS ATTRIBUTES(UNBUFFERED)

  CLOSE WINDOW __fgldblogin

  IF int_flag THEN
     LET int_flag = FALSE
     RETURN FALSE, NULL, NULL, NULL
  ELSE
     RETURN TRUE, dbname, username, password
  END IF

END FUNCTION

#+ Opens a simple login dialog.
#+ @returnType Integer, String, String
#+ @return 1: status (zero = ok), username and password
#+ @param title The title of the login dialog
#+ @param comment The comment to be displayed in the login dialog
#+ @param username Default value for the database user
#+ @param password Default value for the user password
PUBLIC FUNCTION sadzp340_dlg_login(title,comment,username,password)
  DEFINE title, comment, dbname, username, password STRING
  DEFINE s INTEGER
  CALL sadzp340_dlg_dblogin(title,comment,"*",username,password)
       RETURNING s, dbname, username, password
  RETURN s, username, password
END FUNCTION

--------------------------------------------------------------------------------

#+ Opens a dialog box to enter a value.
#+ @returnType String
#+ @return The value enter by the user, or NULL if canceled.
#+ @param title The title of the dialog
#+ @param comment The comment to be displayed in the dialog
#+ @param label The label to be displayed in the dialog
#+ @param defval The default value
#+ @param options No used yet
PUBLIC FUNCTION sadzp340_dlg_prompt(title,comment,label,defval,options)
  DEFINE title, comment, label, defval, options STRING
  DEFINE w ui.Window
  DEFINE f ui.Form
  DEFINE value STRING

  OPEN WINDOW __fgltprompt WITH FORM "fgltprompt"
       ATTRIBUTES(STYLE="dialog",TEXT=title)

  LET w = ui.Window.getCurrent()
  LET f = w.getForm()

  IF comment IS NULL THEN
     CALL f.setFieldHidden("comment", 1)
  ELSE
     DISPLAY BY NAME comment
  END IF
  IF label IS NULL THEN
     CALL f.setFieldHidden("label", 1)
  ELSE
     DISPLAY BY NAME label
  END IF

  LET value = defval

  LET int_flag = FALSE
  INPUT BY NAME value
        WITHOUT DEFAULTS ATTRIBUTES(UNBUFFERED)

  CLOSE WINDOW __fgltprompt

  IF int_flag THEN
     LET int_flag = FALSE
     LET value = NULL
  END IF

  RETURN value

END FUNCTION

--------------------------------------------------------------------------------

#+ Opens a dialog box to select an option in a list.
#+ @returnType Integer
#+ @return The ordinal of the selected option, or zero if canceled.
#+ @param title The title of the dialog
#+ @param comment The comment to be displayed in the dialog
#+ @param icon The image file to be displayed in the dialog
PUBLIC FUNCTION sadzp340_dlg_choice(title,comment,options,defopt)
  DEFINE title, comment, options STRING
  DEFINE defopt INTEGER
  DEFINE w ui.Window
  DEFINE f ui.Form
  DEFINE choice INTEGER

  OPEN WINDOW __fgltchoice WITH FORM "fgltchoice"
              ATTRIBUTES(STYLE="dialog",TEXT=title)

  LET w = ui.Window.getCurrent()
  LET f = w.getForm()

  IF comment IS NULL THEN
     CALL f.setFieldHidden("comment", 1)
  ELSE
     DISPLAY BY NAME comment
  END IF

  LET w = ui.Window.getCurrent()
  CALL sadzp340_dlg_fgl_choice_fill(w.getForm(),options)

  LET choice = defopt

  LET int_flag = FALSE
  INPUT BY NAME choice WITHOUT DEFAULTS ATTRIBUTES(UNBUFFERED)

  CLOSE WINDOW __fgltchoice

  IF int_flag THEN
     LET int_flag = FALSE
     LET choice = 0
  END IF

  RETURN choice

END FUNCTION

PRIVATE FUNCTION sadzp340_dlg_fgl_choice_fill(form,options)
  DEFINE options STRING
  DEFINE form ui.Form
  DEFINE t base.StringTokenizer
  DEFINE n, c om.DomNode
  DEFINE i INTEGER

  LET n = form.findNode("FormField","formonly.choice")
  IF n IS NULL THEN RETURN END IF
  LET n = n.getFirstChild()
  IF n IS NULL THEN RETURN END IF

  LET i = 1
  LET t = base.StringTokenizer.create(options,"|")
  WHILE t.hasMoreTokens()
    LET c = n.createChild("Item")
    CALL c.setAttribute("name",i)
    CALL c.setAttribute("text",t.nextToken())
    CALL n.appendChild(c)
    LET i = i + 1
  END WHILE

END FUNCTION

